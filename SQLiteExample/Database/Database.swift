//
//  Database.swift
//  SQLiteExample
//
//  Created by Hoàng Khánh on 4/22/18.
//  Copyright © 2018 Hoàng Khánh. All rights reserved.
//

import Foundation
import SQLite

class DataBase {
    static let shared = DataBase()
    public let connection: Connection?
    public let databaseFileName = "sqliteExample.sqlite3"
    private init() {
        let dbPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as String?
        do {
            connection = try Connection("\(String(describing: dbPath))/(databaseFileName)")
        } catch {
            connection = nil
            let nserror = error as NSError
            print("Cannot connect to Database. Error: \(nserror), \(nserror.userInfo)")
        }
    }
}
