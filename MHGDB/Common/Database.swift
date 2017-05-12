//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import Foundation
import GRDB

class Database {
    static let shared = Database()
    let dbQueue: DatabaseQueue
    
    init() {
        do {
            dbQueue = try DatabaseQueue(path: Bundle.main.path(forResource: "mhgen", ofType: "db")!)
        } catch {
            fatalError("Could not load DB")
        }
    }
    
    func fetch<T: RowConvertible>(_ query: String) -> T? {
        do {
            return try dbQueue.inDatabase { db in
                return try T.fetchOne(db, query)
            }
        } catch {
            return nil
        }
    }
    
    func fetch<T: RowConvertible>(_ query: String) -> [T] {
        do {
            return try dbQueue.inDatabase { db in
                return try T.fetchAll(db, query)
            }
        } catch let error as DatabaseError {
            print(error.description)
            
        } catch let error as NSError {
            print(error.description)
        }
        
        // Should this just fail?
        return [T]()
    }
    
    func getStrings(_ query: String, column: String = "value") -> [String] {
        // this implementation is silly
        RowString.column = column
        let rows = fetch(query) as [RowString]
        let values = rows.flatMap { $0.value }
        return values
    }
}

class RowString: RowConvertible {
    static var column = "value"
    let value: String?
    required init(row: Row) {
        value = row => RowString.column
    }
}

precedencegroup GRDBPrecedence {
    associativity: right
    higherThan: CastingPrecedence
}

infix operator =>: GRDBPrecedence

public func => <Value: DatabaseValueConvertible>(row: Row, column: String) -> Value {
    return row.value(named: column)
}

public func => <Value: DatabaseValueConvertible>(row: Row, column: String) -> Value? {
    return row.value(named: column)
}

/* Not supported till Swift 4
 subscript<Value: DatabaseValueConvertible>(row: Row, column: String) -> Value? {
    return row.value(named: column)
}*/
