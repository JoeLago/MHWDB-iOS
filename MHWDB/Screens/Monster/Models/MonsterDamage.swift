//
//  MonsterDamage.swift
//  MHGDB
//
//  Created by Joe on 5/6/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class MonsterDamageByPart {
    var state = "Normal"
    var damage = [MonsterDamage]()
}

class MonsterDamage: Decodable, FetchableRecord {
    var bodyPart: String
    var cut: Int
    var impact: Int
    var shot: Int
    var fire: Int
    var water: Int
    var ice: Int?
    var thunder: Int
    var dragon: Int
    var ko: Int

    enum CodingKeys: String, CodingKey {
        case bodyPart = "name", cut, impact, shot, fire, water, ice, thunder, dragon, ko
    }
}

extension Database {

    func damageByPart(monsterId: Int) -> [MonsterDamageByPart] {
        var parts = [String: MonsterDamageByPart]()
        let dmgs: [MonsterDamage] = Database.shared.monsterDamage(monsterId: monsterId)

        for dmg in dmgs {
            let state = dmg.bodyPart.slice(from: "(", to: ")") ?? "Normal"
            let existing = parts[state] ?? MonsterDamageByPart()
            if parts[state] == nil {
                parts[state] = existing
                existing.state = state
            }
            dmg.bodyPart = dmg.bodyPart.replacingOccurrences(of: " (\(state))", with: "")
            existing.damage.append(dmg)
        }

        // Reversed puts normal on top, should do a more safe algorithm
        return [MonsterDamageByPart](parts.values).reversed()
    }

    func monsterDamage(monsterId: Int) -> [MonsterDamage] {
        let query = Query(table: "monster_hitzone")
            .join(table: "monster_hitzone_text")
            .filter("monster_id", equals: monsterId)
        return fetch(query)
    }
}
