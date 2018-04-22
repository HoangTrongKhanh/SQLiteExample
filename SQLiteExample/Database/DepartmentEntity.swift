//
//  DepartmentEntity.swift
//  SQLiteExample
//
//  Created by Hoàng Khánh on 4/22/18.
//  Copyright © 2018 Hoàng Khánh. All rights reserved.
//

import Foundation
import SQLite

class DepartmentEntity {
    static let shared = DepartmentEntity()
    private let tblDepartment = Table("tblDepartment")
    
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let address = Expression<String>("adress")
    private let city = Expression<String>("city")
    private let zipCode = Expression<Int64>("zipCode")
    
    private init() {
        do {
            if let connection = DataBase.shared.connection {
                try connection.run(tblDepartment.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.name)
                    table.column(self.address)
                    table.column(self.city)
                    table.column(self.zipCode)
                }))
                print("Create table tblDepartment successfully.")
            } else {
                print("Create table tblDepartment failed.")
            }
        } catch {
            let nserror = error as NSError
            print("Create table tblDepartment failed. Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func insert(name: String, address: String, city: String, zipCode: Int64?) -> Int64? {
        do {
            let insert = tblDepartment.insert(self.name <- name, self.address <- address, self.city <- city, self.zipCode <- zipCode ?? 0)
            let insertedId = try DataBase.shared.connection?.run(insert)
            return insertedId
        } catch {
            let nserror = error as NSError
            print("Cannot insert new Department. Error: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    func queryAll() -> AnySequence<Row>? {
        do {
            return try DataBase.shared.connection?.prepare(self.tblDepartment)
        } catch {
            let nserror = error as NSError
            print("Cannot query all tblDepartment. Error: \(nserror), \(nserror.userInfo)")
            return nil
        }
    }
    
    func toString(department: Row) {
        print("""
            Department details. Name: \(department[self.name]),\
            address: \(department[self.address]),
            city: \(department[self.city]), 
            zipCode: \(department[self.zipCode])
            """)
    }
}
