//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Armor: RowConvertible, Decodable {

    enum Slot: String, Decodable {
        case head, chest, arms, waist, legs

        var iconName: String {
            switch self {
            case .chest: return "body" // too lazy to rename icon
            default: return rawValue
            }
        }
    }

    let id: Int
    let name: String
    let defense: Int
    let defenseMax: Int
    //let buy: Int
    //let sell: Int
    //let slots: Int
    let rarity: Int
    let slot: Slot?

    var icon: String { return "\(slot?.iconName ?? "")\(rarity).png" }
    //var slotsString: String { return String(repeating: "O", count: slots) + String(repeating: "-", count: 3 - slots) }

    lazy var skills: [ArmorSkill] = { return Database.shared.armorSkills(armorId: id) }()
    lazy var components: [ArmorComponent] = { return Database.shared.armorComponents(armorId: self.id) }()

    enum CodingKeys: String, CodingKey {
        case id, name, defense = "defense_base", defenseMax = "defense_max", rarity, slot = "armor_type"
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
