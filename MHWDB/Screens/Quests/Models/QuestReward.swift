//
//  QuestReward.swift
//  MHWDB
//
//  Created by Joe on 8/10/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

class QuestReward: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let percentage: Int
    let stack: Int
    let group: String

    let itemId: Int
    lazy var item: Item = { Database.shared.item(id: itemId) }()
    let questId: Int
    lazy var quest: Quest = { Database.shared.quest(id: questId) }()
}

extension Database {
    func questRewards(questId: Int) -> [QuestReward] {
        let query = Query(table: "quest_reward", addLanguageFilter: false)
            .filter("quest_id", equals: questId)
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
