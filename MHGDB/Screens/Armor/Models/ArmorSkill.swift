//
//  ArmorSkill.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSkill: RowConvertible, Decodable {
    let skillId: Int
    var name: String
    var value: Int
}

extension Database {
    func armorSkills(itemId: Int) -> [ArmorSkill] {
        let query = "SELECT *,"
            + " skill_trees.name AS skillname,"
            + " skill_trees._id AS skillid"
            + " FROM item_to_skill_tree"
            + " LEFT JOIN items ON item_to_skill_tree.item_id = items._id"
            + " LEFT JOIN skill_trees ON item_to_skill_tree.skill_tree_id = skill_trees._id"
            + " WHERE items._id == \(itemId)"
        return fetch(query)
    }
}
