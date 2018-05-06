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
            dbQueue = try DatabaseQueue(path: Bundle.main.path(forResource: "mhw", ofType: "db")!)
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
    
    // TODO: kill all the other fetch functions
    func fetch<T: RowConvertible>(_ query: Query) -> [T] {
        return fetch(query.query)
    }
    
    func fetch<T: RowConvertible>(_ query: String, params: [DatabaseValueConvertible?]? = nil) -> [T] {
        do {
            return try dbQueue.inDatabase { db in
                var arguments: StatementArguments? = nil
                if let params = params {
                    arguments = StatementArguments(params)
                }
                
                return try T.fetchAll(db, query, arguments: arguments, adapter: nil)
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
        let values = rows.compactMap { $0.value }
        return values
    }
    
    func fetch<T: RowConvertible>(select: String, order: String? = nil, filter: String? = nil, search: String? = nil) -> [T] {
        var params = [DatabaseValueConvertible?]()
      
        let hasFilter = (filter?.count ?? 0) > 0
        var finalFilter = ""
        
        if hasFilter || search != nil {
            finalFilter += "WHERE "
        }
        
        if let filter = filter {
            finalFilter += filter
        }
        
        if let search = search, search.count > 0 {
            finalFilter += (hasFilter ? " AND " : "") + "name LIKE ?"
            params.append("%\(search)%")
        }
        
        let orderString = order != nil ? "ORDER BY \(order ?? "")" : ""
        
        let query = [select, finalFilter, orderString].joined(separator: " ")
        
        return fetch(query, params: params)
    }
}

class RowString: RowConvertible {
    static var column = "value"
    let value: String?
    required init(row: Row) {
        value = row[RowString.column]
    }
}
