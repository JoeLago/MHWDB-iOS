//
//  Moneter.swift
//  MHGDB
//
//  Created by Joe on 5/5/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class Monster: Decodable, RowConvertible {
    enum Size: String, Decodable {
        case large = "large"
        case small = "small"
    }
    
    var id: Int
    var name: String
    var icon: String? {
        return name.lowercased().replacingOccurrences(of: " ", with: "-") + ".png"
    }
    var size: Size?
    
    lazy var habitats: [MonsterHabitat] = { return Database.shared.habitats(monsterId: id) }()
    lazy var damageByPart: [MonsterDamageByPart] = { return Database.shared.damageByPart(monsterId: id) }()
    func rewards(rank: Quest.Rank) -> [MonsterReward] { return Database.shared.rewards(monsterId: id, rank: rank) }
    func rewardsByCondition(rank: Quest.Rank) -> [String: [MonsterReward]] { return Database.shared.rewardsByCondition(monsterId: id, rank: rank)}
}

extension Database {
    func monster(id: Int) -> Monster {
        let query = Query(table: "monster").join(table: "monster_text").filter(id: id)
        return fetch(query)[0]
    }
    
    func monsters(_ search: String? = nil, size: Monster.Size? = nil) -> [Monster] {
        let query = Query(table: "monster").join(table: "monster_text").order(by: "name")
        if let size = size {
            query.filter("size", equals: size.rawValue)
        }
        return fetch(query)
    }
}
