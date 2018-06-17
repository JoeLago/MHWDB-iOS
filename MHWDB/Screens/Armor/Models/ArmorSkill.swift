//
//  ArmorSkill.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSkill: RowConvertible, Decodable {
    let skillTreeId: Int
    var name: String
    var description: String
    var level: Int

    enum CodingKeys: String, CodingKey {
        case skillTreeId = "skilltree_id", name, description, level
    }
}

extension Database {
    func armorSkills(armorId: Int) -> [ArmorSkill] {
        let query = Query(table: "armor_skill")
            .join(table: "skilltree", on: "skilltree_id")
            .join(origin: "skilltree", table: "skilltree_text")
            .filter("armor_id", equals: armorId)
        return fetch(query)
    }
}
