//
//  ItemLocation.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemLocation: RowConvertible, Decodable {
    var id: Int
    var name: String
    var icon: String
    var rank: String // TODO: use enum
    var area: String
    var site: String
    var stack: Int
    var chance: Int
    var isFixed: Bool
    var isRare: Bool
    var group: Int

    var nodeName: String {
        return "\(area) \(isFixed ? "Fixed" : "Random") \(site) \(group) \(isRare ? " Rare" : "")"
    }
}

extension Database {
    func locations(itemId: Int) -> [ItemLocation] {
        let query = "SELECT *,"
            + " locations.name AS locationname"
            + " FROM gathering"
            + " LEFT JOIN items on gathering.item_id = items._id"
            + " LEFT JOIN locations on gathering.location_id = locations._id"
            + " WHERE items._id == \(itemId)"
        return fetch(query)
    }
}
