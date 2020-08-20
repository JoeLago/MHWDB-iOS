//
//  QuestReward.swift
//  MHWDB
//
//  Created by Joe on 8/10/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

class QuestReward: Decodable, FetchableRecord, Identifiable, IconRepresentable {
    // Can have same item with different % for same quest, think they should have different groups but don't always seem to
    var id: (Int, Int) { return (itemId, percentage) }
    let itemId: Int
    var name: String
    var iconName: String?
    var iconColor: IconColor?
    var percentage: Int
    var stack: Int
    var group: String
}

extension Database {
    func questRewards(questId: Int) -> [QuestReward] {
        let query = Query(table: "quest_reward", addLanguageFilter: false)
            .join(table: "item", on: "item_id")
            .join(origin: "item", table: "item_text", addLanguageFilter: true)
            .filter("quest_id", equals: questId)
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
