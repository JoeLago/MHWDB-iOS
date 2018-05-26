//
//  ItemComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemComponent: RowConvertible, Decodable {
    var createdId: Int
    var name: String
    var icon: String?
    var quantity: Int

    enum CodingKeys: String, CodingKey {
        case createdId = "created_id", name, icon, quantity
    }
}

extension Database {
    func armor(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "armor_recipe")
            .column("armor_id", as: "created_id")
            .join(table: "armor", on: "armor_id")
            .join(originTable: "armor", table: "armor_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func weapons(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "weapon_recipe")
            .column("weapon_id", as: "created_id")
            .join(table: "weapon", on: "weapon_id")
            .join(originTable: "weapon", table: "weapon_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func charms(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "charm_recipe")
            .column("charm_id", as: "created_id")
            .join(table: "charm", on: "charm_id")
            .join(originTable: "charm", table: "charm_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }
}
