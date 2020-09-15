//
//  MonsterHabitat.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class MonsterHabitat: Decodable, FetchableRecord, Identifiable {
    var id: Int { return locationId }
    var locationId: Int
    var name: String?
    var startArea: String?
    var moveArea: String?
    var restArea: String?
    var string: String {
        return [startArea, moveArea, restArea].compactMap { $0 }.joined(separator: " > ")
    }
}

extension Database {
    func habitats(monsterId: Int) -> [MonsterHabitat] {
        let query = Query(table: "monster_habitat")
            .join(table: "location_text", on: "location_id")
            .join(table: "monster", on: "monster_id")
            .filter("monster.id", equals: monsterId)
        return fetch(query)
    }
}
