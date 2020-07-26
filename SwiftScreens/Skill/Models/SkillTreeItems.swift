//
//  SkillTreeItems.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class SkillTreeItem: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let level: Int
}

extension Database {
    func skillCharms(skillTreeId: Int) -> [SkillTreeItem] {
        let query = Query(table: "charm_skill")
            .join(table: "charm_text", on: "charm_id", addLanguageFilter: true)
            .filter("skilltree_id", equals: skillTreeId)
            .order(by: "level", direction: .dec)
        return fetch(query)
    }

    func skillArmor(skillTreeId: Int, slot: Armor.Slot) -> [SkillTreeItem] {
        let query = Query(table: "armor_skill")
            .join(table: "armor_text", on: "armor_id", addLanguageFilter: true)
            .join(table: "armor", on: "armor_id")
            .filter("skilltree_id", equals: skillTreeId)
            .filter("armor_type", equals: slot.rawValue)
            .order(by: "level", direction: .dec)
        return fetch(query)
    }
}
