//
//  LocationItems.swift
//  MHWDB
//
//  Created by Joe on 5/26/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class LocationItem: FetchableRecord, Decodable {
    var itemId: Int
    var name: String?
    var icon: String?
    var rank: String?
    var percentage: Int?
    var stack: Int?

    var nodeName: String { return "" } // Need to specify node when we get more data
}

extension Database {
    func locationItems(locationId: Int, rank: Quest.Rank) -> [LocationItem] {
        let query = Query(table: "location_item")
            .column("item_id", as: "itemId")
            .join(table: "item_text", on: "item_id", equals: "id")
            .filter("location_id", equals: locationId)
            .filter("rank", equals: rank.rawValue)
        return fetch(query)
    }
}
