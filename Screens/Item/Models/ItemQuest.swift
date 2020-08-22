//
//  ItemQuest.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

extension Database {
    func itemQuests(itemId: Int) -> [QuestReward] {
        let query = Query(table: "quest_reward", addLanguageFilter: false)
            .filter("item_id", equals: itemId)
            .order(by: "percentage", direction: .dec)
        return fetch(query)
    }
}
