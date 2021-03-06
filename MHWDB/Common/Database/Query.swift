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
    static var languageId = "en"

    struct Join {
        let originTable: String
        let originAttribute: String
        let joinTable: String
        let joinTableAs: String?
        let joinAttribute: String

        var query: String {
            let join = "LEFT JOIN \(joinTable)"
            let joinAs = joinTableAs.map { "AS \($0)" } ?? nil
            let joinOn = "ON \(originTable).\(originAttribute) = \(joinAttribute)"
            return [join, joinAs, joinOn].compactMap({ $0 }).joined(separator: " ")
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

    struct OrFilter {
        let filters: [Filter]

        var query: String {
            return "(\(filters.map({ $0.query }).joined(separator: " OR ")))"
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

        init(attribute: String, value: Any, comparison: Comparison = .equal) {
            self.attribute = attribute
            self.value = value
            self.comparison = comparison
        }
    }

    struct Column {
        let column: String
        let assign: String?

        var query: String {
            return [column, assign].compactMap({ $0 }).joined(separator: " AS ")
        }
    }

    struct Group {
        enum Agggregate: String {
            case min, max, sum, count, avg
        }

        let column: String
        let function: Agggregate?
        let asColumn: String
    }

    var table: String
    var baseColumns: String = "*"
    var columns = [Column]()
    var joins = [Join]()
    var orders = [Order]()
    var filters = [Filter]()
    var orFilters = [OrFilter]()
    var groupings = [Group]()

    var query: String {

        var columnQuery = baseColumns
        if groupings.count > 0 {
            columnQuery += ", " + groupings.map { grouping in
                grouping.function.map({ "\($0.rawValue.uppercased())(\(grouping.column))" })
                ?? "\(grouping.column)"
                    + " AS \(grouping.asColumn)"
            }.joined(separator: ", ")
        } else {
            if columns.count > 0 {
                columnQuery += ", " + columns.map({ $0.query }).joined(separator: ", ")
            }
        }

        let action = "SELECT \(columnQuery) FROM \(table)"
        let join = joins.map({ $0.query }).joined(separator: " ")

        var filter: String?
        if filters.count > 0 || orFilters.count > 0 {
            let allFitlers = filters.map({ $0.query }) + orFilters.map({ $0.query })
            filter = "WHERE " + allFitlers.joined(separator: " AND ")
        }

        var group: String?
        if groupings.count > 0 {
            group = "GROUP BY " + groupings.map({ $0.column }).joined(separator: ", ")
        }

        var order: String?
        if orders.count > 0 {
            order = "ORDER BY " + orders.map({ $0.query }).joined(separator: ", ")
        }

        let parts = [action, join, filter, group, order].compactMap { $0 }
        let query = parts.joined(separator: " ")
        return query
    }

    init(table: String, language: Filter? = nil) {
        self.table = table
        if let language = language {
            filters.append(language)
        } else {
            filter("lang_id", equals: Query.languageId)
        }
    }

    init(table: String, addLanguageFilter: Bool) {
        self.table = table
        if addLanguageFilter == true {
            filter("lang_id", equals: Query.languageId)
        }
    }

    @discardableResult
    func columns(_ columns: [String]) -> Query {
        baseColumns = columns.joined(separator: ", ")
        return self
    }

    @discardableResult
    func column(_ column: String, as assign: String? = nil) -> Query {
        columns.append(Column(column: column, assign: assign))
        return self
    }

    @discardableResult
    func join(origin: String, table: String, as named: String? = nil, on: String = "id", equals: String? = nil, addLanguageFilter: Bool = false) -> Query {
        let joinAttribute = equals ?? named.map { "\($0).id" } ?? "\(table).id"
        joins.append(Join(originTable: origin, originAttribute: on, joinTable: table, joinTableAs: named, joinAttribute: joinAttribute))
        if addLanguageFilter {
            filter("\(named ?? table).lang_id", equals: Query.languageId)
        }
        return self
    }

    @discardableResult
    func join(table: String, as named: String? = nil, on: String = "id", equals: String? = nil, addLanguageFilter: Bool = false) -> Query {
        let joinAttribute = equals ?? named.map { "\($0).id" } ?? "\(table).id"
        joins.append(Join(originTable: self.table, originAttribute: on, joinTable: table, joinTableAs: named, joinAttribute: joinAttribute))
        if addLanguageFilter {
            filter("\(named ?? table).lang_id", equals: Query.languageId)
        }
        return self
    }

    @discardableResult
    func orFilter(_ filters: [Filter]) -> Query {
        orFilters.append(OrFilter(filters: filters))
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

    @discardableResult
    func group(by attribute: String, function: Group.Agggregate? = nil, as asColumn: String) -> Query {
        groupings.append(Group(column: attribute, function: function, asColumn: asColumn))
        return self
    }
}
