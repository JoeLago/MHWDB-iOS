//
//  Query.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation

// Not very intuitive, could use some thought

class Query {
    struct Join {
        let originTable: String
        let originAttribute: String
        let joinTable: String
        let joinAttribute: String
        
        var query: String {
            return "LEFT JOIN \(joinTable) ON \(originTable).\(originAttribute) = \(joinTable).\(joinAttribute)"
        }
    }
    
    struct Order {
        enum Direction {
            case asc, dec
        }
        let attribute: String
        let direction: Direction
        
        var query: String {
            return "\(attribute) \(direction == .asc ? "ASC" : "DESC")"
        }
    }
    
    struct Filter {
        let attribute: String
        let value: Any
        let comparison: Comparison
        
        enum Comparison {
            case equal, like, notLike
        }
        
        var query: String {
            switch (value, comparison) {
            case is (Int, Comparison): return "\(attribute) = \(value)"
            case (_, .like): return "\(attribute) LIKE '%\(value)%'"
            case (_, .notLike): return "\(attribute) NOT LIKE '%\(value)%'"
            default: return "\(attribute) = '\(value)'"
            }
        }
    }
    
    struct Column {
        let column: String
        let assign: String?
        
        var query: String {
            return [column, assign].compactMap({ $0 }).joined(separator: " AS ")
        }
    }
    
    var table: String
    var columns = [Column]()
    var joins = [Join]()
    var orders = [Order]()
    var filters = [Filter]()
    
    var query: String {
        
        var columnQuery = "*"
        if columns.count > 0 {
            columnQuery = "*, " + columns.map({ $0.query }).joined(separator: ", ")
        }
        
        let action = "SELECT \(columnQuery) FROM \(table)"
        let join = joins.map({ $0.query }).joined(separator: " ")
        
        var filter = "" // nil?
        if filters.count > 0 {
            filter = "WHERE " + filters.map({ $0.query }).joined(separator: " AND ")
        }
        
        var order = "" // nil?
        if orders.count > 0 {
            order = "ORDER BY " + orders.map({ $0.query }).joined(separator: ", ")
        }
        
        let parts = [action, join, filter, order]
        return parts.joined(separator: " ")
    }
    
    init(table: String, language: Filter? = nil) {
        self.table = table
        if let language = language {
            filters.append(language)
        } else {
            filter("lang_id", equals: "en")
        }
    }
    
    init(table: String, addLanguageFilter: Bool) {
        self.table = table
        if addLanguageFilter == true {
            filter("lang_id", equals: "en")
        }
    }
    
    @discardableResult
    func column(_ column: String, as assign: String? = nil) -> Query {
        columns.append(Column(column: column, assign: assign))
        return self
    }
    
    @discardableResult
    func join(originTable: String, table: String, on: String = "id", equals: String = "id") -> Query {
        joins.append(Join(originTable: originTable, originAttribute: on, joinTable: table, joinAttribute: equals))
        return self
    }
    
    @discardableResult
    func join(table: String, on: String = "id", equals: String = "id") -> Query {
        joins.append(Join(originTable: self.table, originAttribute: on, joinTable: table, joinAttribute: equals))
        return self
    }
    
    @discardableResult
    func filter(_ attribute: String, equals value: Any) -> Query {
        filters.append(Filter(attribute: attribute, value: value, comparison: .equal))
        return self
    }
    
    @discardableResult
    func filter(_ attribute: String, contains value: Any) -> Query {
        filters.append(Filter(attribute: attribute, value: value, comparison: .like))
        return self
    }
    
    @discardableResult
    func filter(_ attribute: String, is comparison: Filter.Comparison, value: Any) -> Query {
        filters.append(Filter(attribute: attribute, value: value, comparison: comparison))
        return self
    }
    
    @discardableResult
    func filter(id: Any) -> Query {
        filters.append(Filter(attribute: "\(table).id", value: id, comparison: .equal))
        return self
    }
    
    @discardableResult
    func order(by attribute: String, direction: Order.Direction = .asc) -> Query {
        orders.append(Order(attribute: attribute, direction: direction))
        return self
    }
}
