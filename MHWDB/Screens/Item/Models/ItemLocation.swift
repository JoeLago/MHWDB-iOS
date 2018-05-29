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
    var name: String?
    var icon: String?
    var rank: String?
    var percentage: Int?
    var stack: Int?

    var nodeName: String { return "" } // Need to specify node when we get more data
}

extension Database {
    func locations(itemId: Int) -> [ItemLocation] {
        let query = Query(table: "location_item")
            .join(table: "location_text", on: "location_id", equals: "id")
            .filter("item_id", equals: itemId)
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
