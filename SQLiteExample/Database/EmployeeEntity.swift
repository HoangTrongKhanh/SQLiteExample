//
//  EmployeeEntity.swift
//  SQLiteExample
//
//  Created by Hoàng Khánh on 4/22/18.
//  Copyright © 2018 Hoàng Khánh. All rights reserved.
//

import Foundation
import SQLite

class EmployeeEntity {
    static let shared = EmployeeEntity()
    private let tblEmployee = Table("tblEmployee")
    
    private let id = Expression<Int64>("id")
    private let name = Expression<String>("name")
    private let hireDate = Expression<Date>("hireDate")
    private let identifier = Expression<String>("identifier")
    private let isManager = Expression<Bool>("isManager")
    private let title = Expression<String>("title")
    
    private let departmentId = Expression<Int64>("departmentId")
    
    private init() {
        do {
            if let connection = DataBase.shared.connection {
                try connection.run(tblEmployee.create(temporary: false, ifNotExists: true, withoutRowid: false, block: { (table) in
                    table.column(self.id, primaryKey: true)
                    table.column(self.name)
                    table.column(self.hireDate)
                    table.column(self.identifier)
                    table.column(self.isManager)
                    table.column(self.title)
                    table.column(self.departmentId)
                }))
                print("Create table tblEmpoyee successfully")
            }
        } catch {
            let nserror = error as NSError
            print("Create table employee failed. Error: \(nserror), \(nserror.userInfo)")
        }
    }
    
    func toString(employee: Row) {
        print("""
            Employee details. Name: \(employee[self.name]),\
            hireDate: \(employee[self.hireDate]),
            identifier: \(employee[self.identifier]),
            isManager: \(employee[self.isManager]),
            title: \(employee[self.title]).
            departmentId: \(employee[self.departmentId])
            """)
    }
    
}
