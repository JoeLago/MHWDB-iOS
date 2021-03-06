//
//  MonsterRewards.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class MonsterReward: FetchableRecord, Decodable, Identifiable, IconRepresentable {
    var id: String { "\(itemId)-\(condition)" }
    var itemId: Int
    var name: String
    var iconName: String?
    var iconColor: IconColor?
    var condition: String
    var rank: Quest.Rank?
    var stackSize: Int?
    var chance: Int?

    enum CodingKeys: String, CodingKey {
        case itemId, name = "itemName", iconName, iconColor, condition, rank, stackSize = "stack", chance = "percentage"
    }
}

struct RewardConditions: Identifiable {
    var id: Int { itemId }
    var itemId: Int
    var name: String
    var conditions: [MonsterReward]
    var icon: Icon? { return conditions.first?.icon }
}

extension Database {

    func rewardsByReward(monsterId: Int, rank: Quest.Rank) -> [RewardConditions] {
        let allRewards = Database.shared.rewards(monsterId: monsterId, rank: rank)

        var conditionsByItemId = [Int: RewardConditions]()
        for reward in allRewards {
            var rewardCondition = conditionsByItemId[reward.itemId]
                ?? RewardConditions(itemId: reward.itemId, name: reward.name, conditions: [MonsterReward]())
            rewardCondition.conditions.append(reward)
            conditionsByItemId[reward.itemId] = rewardCondition
        }

        return Array(conditionsByItemId.values).sorted { $0.name < $1.name }
    }

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
            .order(by: "item_name")
            //.order(by: "monster_reward_condition_text.name")
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
