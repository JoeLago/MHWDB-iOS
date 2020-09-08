//
//  WeaponSkill.swift
//  MHWDB
//
//  Created by Joe on 9/8/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

class WeaponSkill: FetchableRecord, Decodable, Identifiable {
    var id: Int { return skilltreeId }
    let skilltreeId: Int
    var name: String
    var description: String
    var level: Int
    var iconColor: IconColor?
    var icon: Icon { return Icon(name: "armor_skill", color: iconColor) }
}

extension Database {
    func weaponSkills(weaponId: Int) -> [WeaponSkill] {
        let query = Query(table: "weapon_skill")
            .join(table: "skilltree", on: "skilltree_id")
            .join(origin: "skilltree", table: "skilltree_text")
            .filter("weapon_id", equals: weaponId)
        return fetch(query)
    }
}
