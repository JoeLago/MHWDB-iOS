//
//  QuestReward.swift
//  MHWDB
//
//  Created by Joe on 8/10/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

class QuestReward: Decodable, FetchableRecord {
    let itemId: Int
    var name: String
    var icon: String?
    var quantity: Int
    var chance: Int
    var slot: String
}

extension Database {

    var rewardsQuery: String {
        return "SELECT *,"
            + " items._id AS itemid,"
            + " items.name AS itemname,"
            + " items._id AS itemid,"
            + " items.icon_name AS itemicon,"
            + " quests.name AS questname,"
            + " quests._id AS questid"
            + " FROM quest_rewards"
            + " LEFT JOIN items on quest_rewards.item_id = items._id"
            + " LEFT JOIN quests on quest_rewards.quest_id = quests._id "
    }

    func rewards(questId: Int) -> [QuestReward] {
        let query = rewardsQuery + "WHERE quests._id == \(questId)"
        return fetch(query)
    }
}
