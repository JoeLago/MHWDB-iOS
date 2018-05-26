//
//  ItemMonster.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemMonster: RowConvertible, Decodable {
    let monsterId: Int
    let name: String
    let icon: String?
    let condition: String
    let rank: Quest.Rank
    let stack: Int
    let chance: Int

    enum CodingKeys: String, CodingKey {
        case monsterId = "monster_id", name, icon, condition = "condition", rank, stack = "stack_size", chance = "percentage"
    }
}

extension Database {
    func monsters(itemId: Int) -> [ItemMonster] {
        let query = Query(table: "monster_reward", addLanguageFilter: false)
            .column("monster_text.name", as: "name")
            .column("monster_reward_condition_text.name", as: "condition")
            .join(table: "monster", on: "monster_id")
            .join(table: "item", on: "item_id")
            .join(originTable: "monster", table: "monster_text")
            .join(table: "monster_reward_condition_text", on: "condition_id")
            .filter("item_id", equals: itemId)
            .filter("monster_text.lang_id", equals: "en")
            .filter("monster_reward_condition_text.lang_id", equals: "en")
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
