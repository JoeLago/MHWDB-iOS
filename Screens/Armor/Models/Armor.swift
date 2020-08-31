//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Armor: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let defenseBase: Int
    let defenseMax: Int
    let defenseAugmentMax: Int
    let rarity: Int
    let armorType: Slot?
    let slot1: SocketLevel
    let slot2: SocketLevel
    let slot3: SocketLevel
    let female: Bool
    let male: Bool
    var fire: Int
    var water: Int
    var thunder: Int
    var ice: Int
    var dragon: Int
    var recipeId: Int

    var defenseText: String { return "\(defenseBase) - \(defenseMax) (\(defenseAugmentMax))" }
    var icon: Icon { return Icon(name: armorType?.iconName ?? "", rarity: rarity) }

    lazy var skills: [ArmorSkill] = { return Database.shared.armorSkills(armorId: id) }()
    lazy var components: [RecipeComponent] = { return Database.shared.recipeComponents(id: self.recipeId) }()
}

extension Armor {
    enum Slot: String, Decodable, CaseIterable {
        case head, chest, arms, waist, legs

        var iconName: String {
            switch self {
            case .head: return "equipment_head"
            case .chest: return "equipment_chest"
            case .arms: return "equipment_arm"
            case .waist: return "equipment_waist"
            case .legs: return "equipment_leg"
            }
        }
    }

    enum SocketLevel: Int, Decodable {
        case none, one, two, three, four

        var iconName: String? {
            switch self {
            case .none: return "slot_none"
            case .one: return "slot_1_empty"
            case .two: return "slot_2_empty"
            case .three: return "slot_3_empty"
            case .four: return "slot_4_empty"
            }
        }
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
