//
//  SkilltreeArmor.swift
//  MHWDB
//
//  Created by Joe on 8/21/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class SkilltreeArmor: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let level: Int
    let rarity: Int
    let armorType: Armor.Slot
    var icon: Icon { return Icon(name: armorType.iconName, rarity: rarity) }
}

extension Database {

    func skillArmor(skilltreeId: Int, slot: Armor.Slot) -> [SkilltreeArmor] {
        let query = Query(table: "armor_skill")
            .join(table: "armor_text", on: "armor_id", addLanguageFilter: true)
            .join(table: "armor", on: "armor_id")
            .filter("skilltree_id", equals: skilltreeId)
            .filter("armor_type", equals: slot.rawValue)
            .order(by: "level", direction: .dec)
            .order(by: "rarity", direction: .asc)
        return fetch(query)
    }
}
