//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Armor: FetchableRecord, Decodable, Identifiable {

    enum Slot: String, Decodable, CaseIterable {
        case head, chest, arms, waist, legs

        var iconName: String {
            switch self {
            case .head: return "icon_armor_head"
            case .chest: return "icon_armor_body"
            case .arms: return "icon_armor_arms"
            case .waist: return "icon_armor_waist"
            case .legs: return "icon_armor_legs"
            }
        }
    }

    enum SocketLevel: Int, Decodable {
        case none, one, two, three, four

        var iconName: String? {
            switch self {
            case .none: return nil
            case .one: return "DecorationLevelOne"
            case .two: return "DecorationLevelTwo"
            case .three: return "DecorationLevelThree"
            case .four: return "DecorationLevelFour"
            }
        }
    }

    let id: Int
    let name: String
    let defense: Int
    let defenseMax: Int
    let defenseAugment: Int
    //let buy: Int
    //let sell: Int
    //let slots: Int
    let rarity: Int
    let slot: Slot?
    let socketOne: SocketLevel
    let socketTwo: SocketLevel
    let socketThree: SocketLevel
    let isFemale: Bool
    let isMale: Bool
    var fireResistance: Int
    var waterResistance: Int
    var thunderResistance: Int
    var iceResistance: Int
    var dragonResistance: Int
    var recipeId: Int

    var icon: Icon { return Icon(name: slot?.iconName ?? "", rarity: rarity) }

    lazy var skills: [ArmorSkill] = { return Database.shared.armorSkills(armorId: id) }()
    lazy var components: [RecipeComponent] = { return Database.shared.recipeComponents(id: self.recipeId) }()

    enum CodingKeys: String, CodingKey {
        case id, name, defense="defenseBase", defenseMax, defenseAugment="defenseAugmentMax", rarity, slot="armorType", socketOne="slot1", socketTwo="slot2", socketThree="slot3", isFemale="female", isMale="male", fireResistance="fire", waterResistance="water", thunderResistance="thunder", iceResistance="ice", dragonResistance="dragon", recipeId
    }
}

extension Database {

    func armor(id: Int) -> Armor {
        let query = Query(table: "armor")
            .join(table: "armor_text")
            .filter(id: id)
        return fetch(query)[0]
    }

    func armor(_ search: String? = nil, slot: Armor.Slot? = nil) -> [Armor] {
        let query = Query(table: "armor")
            .join(table: "armor_text")
        return fetch(query)
    }

    func armorSetPieces(armorSetId: Int) -> [Armor] {
        let query = Query(table: "armor")
            .join(table: "armor_text")
            .filter("armorset_id", equals: armorSetId)
        return fetch(query)
    }
}
