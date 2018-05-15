//
//  ArmorComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorComponent: RowConvertible, Decodable {
    var itemId: Int
    var name: String
    var icon: String?
    var type: String?
    var quantity: Int?
    
    enum CodingKeys: String, CodingKey {
        case itemId = "item_id", name, icon, type, quantity
    }
}

extension Database {
    func armorComponents(armorId: Int) -> [ArmorComponent] {
        let query = Query(table: "armor_recipe")
            .join(table: "item", on: "item_id")
            .join(originTable: "item", table: "item_text")
            .filter("armor_id", equals: armorId)
        return fetch(query)
    }
}
