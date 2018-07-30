//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Armor: FetchableRecord, Decodable {

    enum Slot: String, Decodable {
        case head, chest, arms, waist, legs

        var iconName: String {
            switch self {
            case .arms: return "arm"
            case .legs: return "leg"
            default: return rawValue
            }
        }
    }

    enum SocketLevel: Int, Decodable {
        case none, one, two, three

        var iconName: String? {
            switch self {
            case .none: return nil
            case .one: return "DecorationLevelOne"
            case .two: return "DecorationLevelTwo"
            case .three: return "DecorationLevelThree"
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

    var icon: String { return "\(slot?.iconName ?? "")\(rarity).png" }
    //var slotsString: String { return String(repeating: "O", count: slots) + String(repeating: "-", count: 3 - slots) }
    var svg: SVGImageModel {
        return SVGImageModel(name: "equipment_\(slot?.iconName ?? "")_base.svg",
            color: Color.colorForRarity(rarity))

    }

    lazy var skills: [ArmorSkill] = { return Database.shared.armorSkills(armorId: id) }()
    lazy var components: [ArmorComponent] = { return Database.shared.armorComponents(armorId: self.id) }()

    enum CodingKeys: String, CodingKey {
        case id, name, defense="defense_base", defenseMax="defense_max", defenseAugment="defense_augment_max", rarity, slot="armor_type", socketOne="slot_1", socketTwo="slot_2", socketThree="slot_3", isFemale="female", isMale="male", fireResistance="fire", waterResistance="water", thunderResistance="thunder", iceResistance="ice", dragonResistance="dragon"
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
