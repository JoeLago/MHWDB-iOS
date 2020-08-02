//
//  ItemComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemComponent: FetchableRecord, Decodable, Identifiable {
    var id: Int { return createdId }
    var createdId: Int
    var name: String
    var icon: String?
    var quantity: Int
}

extension Database {
    func armorComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "armor_recipe")
            .column("armor_id", as: "created_id")
            .join(table: "armor", on: "armor_id")
            .join(origin: "armor", table: "armor_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func weaponComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "weapon_recipe")
            .column("weapon_id", as: "created_id")
            .join(table: "weapon", on: "weapon_id")
            .join(origin: "weapon", table: "weapon_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func charmComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "charm_recipe")
            .column("charm_id", as: "created_id")
            .join(table: "charm", on: "charm_id")
            .join(origin: "charm", table: "charm_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }
}
