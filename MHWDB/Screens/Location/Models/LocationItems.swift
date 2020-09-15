//
//  LocationItems.swift
//  MHWDB
//
//  Created by Joe on 5/26/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class LocationItem: FetchableRecord, Decodable, Identifiable, IconRepresentable {
    var id: Int { return itemId }
    var itemId: Int
    var area: Int
    var nodes: Int
    var percentage: Int?
    var rank: Quest.Rank?
    var stack: Int?

    var name: String
    var iconName: String?
    var iconColor: IconColor?

    var nodeName: String { return "" } // Need to specify node when we get more data
}

extension Database {
    func locationItems(locationId: Int, rank: Quest.Rank? = nil) -> [LocationItem] {
        let query = Query(table: "location_item")
            .join(table: "item", on: "item_id")
            .join(table: "item_text", on: "item_id")
            .filter("location_id", equals: locationId)

        if let rank = rank {
            query.filter("rank", equals: rank.rawValue)
        }

        return fetch(query)
    }
}
