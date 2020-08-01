//
//  ArmorSkill.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSkill: FetchableRecord, Decodable, Identifiable {
    var id: Int { return skilltreeId }
    let skilltreeId: Int
    var name: String
    var description: String
    var level: Int
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
