//
//  CharmItem.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class CharmItem: FetchableRecord, Decodable {
    var id: Int
    var name: String
    var icon: String?
    var quantity: Int
}

extension Database {
    func charmItems(charmId: Int) -> [CharmItem] {
        let query = Query(table: "charm_recipe")
            .join(table: "item_text", on: "item_id")
            .filter("charm_id", equals: charmId)
        return fetch(query)
    }
}
