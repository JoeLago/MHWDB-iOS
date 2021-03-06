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
    var quantity: Int
    let rarity: Int

    // Can be one of these
    var imageName: String?
    let armorType: Armor.Slot?
    var weaponType: WeaponType?

    var icon: Icon? {
        return imageName.map { Icon(name: $0, rarity: rarity) }
            ?? armorType.map { Icon(name: $0.iconName, rarity: rarity) }
            ?? weaponType.map { Icon(name: $0.imageName, rarity: rarity) }
    }
}

extension Database {
    func armorComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "recipe_item")
            .column("armor.id", as: "created_id")
            .join(table: "armor", on: "recipe_id", equals: "armor.recipe_id")
            .join(origin: "armor", table: "armor_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func weaponComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "recipe_item")
            .column("weapon.id", as: "created_id")
            .join(table: "weapon", on: "recipe_id", equals: "weapon.upgrade_recipe_id") // TODO: OR weapon.create_recipe_id
            .join(origin: "weapon", table: "weapon_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }

    func charmComponents(itemId: Int) -> [ItemComponent] {
        let query = Query(table: "recipe_item")
            .column("'equipment_charm'", as: "image_name")
            .column("charm.id", as: "created_id")
            .join(table: "charm", on: "recipe_id", equals: "charm.recipe_id")
            .join(origin: "charm", table: "charm_text")
            .filter("item_id", equals: itemId)
        return fetch(query)
    }
}
