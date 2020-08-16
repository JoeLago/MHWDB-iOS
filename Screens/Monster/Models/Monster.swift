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
    var description: String?
    var icon: String? { return "\(id)" }
    var size: Size?

    var hasWeakness: Bool
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

    var hasAltWeakness: Bool
    var altWeaknessBlast: Int?
    var altWeaknessDragon: Int?
    var altWeaknessFire: Int?
    var altWeaknessIce: Int?
    var altWeaknessParalysis: Int?
    var altWeaknessPoison: Int?
    var altWeaknessSleep: Int?
    var altWeaknessStun: Int?
    var altWeaknessThunder: Int?
    var altWeaknessWater: Int?

    var pitfallTrap: Bool
    var shockTrap: Bool
    var vineTrap: Bool

    var ailmentBlastblight: Bool?
    var ailmentBleed: Bool?
    var ailmentDefensedown: Bool?
    var ailmentDragonblight: Bool?
    var ailmentEffluvia: Bool?
    var ailmentFireblight: Bool?
    var ailmentIceblight: Bool?
    var ailmentMud: Bool?
    var ailmentParalysis: Bool?
    var ailmentPoison: Bool?
    var ailmentRegional: Bool?
    var ailmentRoar: String?
    var ailmentSleep: Bool?
    var ailmentStun: Bool?
    var ailmentThunderblight: Bool?
    var ailmentTremor: String?
    var ailmentWaterblight: Bool?
    var ailmentWind: String?

    lazy var lowRankRewards: [RewardConditions] = { rewardsByReward(rank: .low) }()
    lazy var highRankRewards: [RewardConditions] = { rewardsByReward(rank: .high) }()
    lazy var gRankRewards: [RewardConditions] = { rewardsByReward(rank: .master) }()

    lazy var habitats: [MonsterHabitat] = { return Database.shared.habitats(monsterId: id) }()
    lazy var hitzones: [MonsterHitzone] = { return Database.shared.hitzones(monsterId: id) }()
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
        let query = Query(table: "monster")
            .join(table: "monster_text")
            .order(by: "order_id")
        if let size = size {
            query.filter("size", equals: size.rawValue)
        }
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
