//
//  MonsterDamage.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

struct MonsterHitzone: FetchableRecord, Decodable {
    var name: String
    var cut: Int
    var dragon: Int
    var fire: Int
    var ice: Int
    var impact: Int
    var ko: Int
    var shot: Int
    var thunder: Int
    var water: Int

    var allValues: [Int] {
        return [cut, dragon, fire, ice, impact, ko, shot, thunder, water]
    }
}

extension Database {

    func hitzones(monsterId: Int) -> [MonsterHitzone] {
        let query = Query(table: "monster_hitzone")
            .join(table: "monster_hitzone_text")
            .filter("monster_id", equals: monsterId)
        return fetch(query)
    }
}
