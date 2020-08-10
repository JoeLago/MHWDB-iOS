//
//  QuestMonster.swift
//  MHWDB
//
//  Created by Joe on 8/10/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

class QuestMonster: Decodable, FetchableRecord, Identifiable {
    var id: Int { return monsterId }
    let monsterId: Int
    let name: String
    var startArea: String?
    var moveArea: String?
    var restArea: String?
    var locations: String {
      return [startArea, moveArea, restArea].compactMap { $0 }.joined(separator: " > ")
    }
    let icon: String?
}

extension Database {

    func monsters(questId: Int) -> [QuestMonster] {
        // The monster_habitat night locations use day counterpart id 100 off
        let query = "SELECT *,"
            + " monsters._id AS monsterid,"
            + " monsters.name AS monstername,"
            + " monsters.icon_name as monstericon"
            + " FROM monster_to_quest"
            + " LEFT JOIN quests on monster_to_quest.quest_id = quests._id"
            + " LEFT JOIN monsters on monster_to_quest.monster_id = monsters._id"
            + " LEFT JOIN monster_habitat on monster_habitat.monster_id = monsters._id"
            + " AND (monster_habitat.location_id = quests.location_id OR monster_habitat.location_id = quests.location_id - 100)"
            + " WHERE quests._id == \(questId)"
        return fetch(query)
    }
}
