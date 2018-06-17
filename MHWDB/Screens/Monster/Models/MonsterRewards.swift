//
//  MonsterRewards.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class MonsterReward: RowConvertible, Decodable {
    var itemId: Int
    var name: String
    var icon: String?
    var condition: String
    var rank: Quest.Rank?
    var stackSize: Int?
    var chance: Int?

    enum CodingKeys: String, CodingKey {
        case itemId = "item_id", name = "item_name", icon, condition = "condition", rank, stackSize = "stack", chance = "percentage"
    }
}

extension Database {
    func rewardsByCondition(monsterId: Int, rank: Quest.Rank) -> [String: [MonsterReward]] {
        let allRewards = Database.shared.rewards(monsterId: monsterId, rank: rank)
        var rewardsByCondition = [String: [MonsterReward]]()
        for reward in allRewards {
            var condition = rewardsByCondition[reward.condition] ?? [MonsterReward]()
            condition.append(reward)
            rewardsByCondition[reward.condition] = condition
        }
        return rewardsByCondition
    }

    func rewards(monsterId: Int, rank: Quest.Rank) -> [MonsterReward] {
        let query = Query(table: "monster_reward", addLanguageFilter: false)
            .column("item_text.name", as: "item_name")
            .column("monster_reward_condition_text.name", as: "condition")
            .join(table: "item", on: "item_id")
            .join(origin: "item", table: "item_text", addLanguageFilter: true)
            .join(table: "monster_reward_condition_text", on: "condition_id", addLanguageFilter: true)
            .filter("monster_id", equals: monsterId)
            .filter("rank", equals: rank.rawValue)
            .order(by: "monster_reward_condition_text.name")
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
