//
//  ItemQuest.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemQuest: RowConvertible, Decodable {
    let questId: Int
    let name: String
    let icon: String?
    let quantity: Int
    let chance: Int
    let slot: String
    let stars: Int
    let hub: String
}

extension Database {
    
    func rewards(itemId: Int) -> [ItemQuest] {
        
        
        let query = "SELECT *,"
            + " items._id AS itemid,"
            + " items.name AS itemname,"
            + " items._id AS itemid,"
            + " items.icon_name AS itemicon,"
            + " quests.name AS questname,"
            + " quests._id AS questid"
            + " FROM quest_rewards"
            + " LEFT JOIN items on quest_rewards.item_id = items._id"
            + " LEFT JOIN quests on quest_rewards.quest_id = quests._id "
            + " WHERE items._id == \(itemId)"
            + " ORDER BY hub, stars, percentage DESC"
        return fetch(query)
    }
}
