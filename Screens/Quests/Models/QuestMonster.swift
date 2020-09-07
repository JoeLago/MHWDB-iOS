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
    let quantity: Int
    let isObjective: Bool
    let startArea: String?
    let moveArea: String?
    let restArea: String?
    var locations: String? {
        let locations = [startArea, moveArea, restArea].compactMap { $0 }.joined(separator: " > ")
        return locations.count > 0 ? locations : nil
    }
    var icon: Icon? { return Icon(name: "\(id)") }
}

extension Database {

    func monsters(questId: Int) -> [QuestMonster] {
        let query = Query(table: "quest_monster", addLanguageFilter: false)
            .join(table: "monster", on: "monster_id")
            .join(origin: "monster", table: "monster_text", addLanguageFilter: true)
            // TODO: We need to be able join on location_id and monster_id to get monster_habitat
            //.join(origin: "monster", table: "monster_habitat")
            .filter("quest_id", equals: questId)
            .order(by: "is_objective", direction: .dec)
        return fetch(query)
    }
}
