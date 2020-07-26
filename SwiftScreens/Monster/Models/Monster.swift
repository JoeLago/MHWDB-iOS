//
//  Moneter.swift
//  MHGDB
//
//  Created by Joe on 5/5/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class Monster: Decodable, FetchableRecord, Identifiable {
    enum Size: String, Decodable {
        case large
        case small
    }

    var id: Int
    var name: String
    var icon: String? { return size == .large ? "\(id)" : nil }
    var size: Size?

    var weaknessBlast: Int?
    var weaknessDragon: Int?
    var weaknessFire: Int?
    var weaknessIce: Int?
    var weaknessParalysis: Int?
    var weaknessPoison: Int?
    var weaknessSleep: Int?
    var weaknessStun: Int?
    var weaknessThunder: Int?
    var weaknessWater: Int?

    lazy var lowRankRewards: [RewardConditions] = { rewardsByReward(rank: .low) }()
    lazy var highRankRewards: [RewardConditions] = { rewardsByReward(rank: .high) }()
    lazy var gRankRewards: [RewardConditions] = { rewardsByReward(rank: .g) }()

    lazy var habitats: [MonsterHabitat] = { return Database.shared.habitats(monsterId: id) }()
    lazy var damageByPart: [MonsterDamageByPart] = { return Database.shared.damageByPart(monsterId: id) }()
    func rewards(rank: Quest.Rank) -> [MonsterReward] { return Database.shared.rewards(monsterId: id, rank: rank) }
    func rewardsByCondition(rank: Quest.Rank) -> [String: [MonsterReward]] { return Database.shared.rewardsByCondition(monsterId: id, rank: rank)}
    func rewardsByReward(rank: Quest.Rank) -> [RewardConditions] { return Database.shared.rewardsByReward(monsterId: id, rank: rank) }
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
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
