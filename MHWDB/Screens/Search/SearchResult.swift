//
//  SearchResult.swift
//  MHWDB
//
//  Created by Joe on 12/7/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

struct SearchResponse {
    var searchText: String
    var monsters: [MonsterSearchResult] = []
    var items: [ItemSearchResult] = []
    var weapons: [WeaponSearchResult] = []
    var armor: [ArmorSearchResult] = []
    var quests: [QuestSearchResult] = []
    var locations: [LocationSearchResult] = []
    var skills: [SkillTreeSearchResult] = []
}

extension SearchResponse: Equatable {
    static func == (lhs: SearchResponse, rhs: SearchResponse) -> Bool {
        return lhs.searchText == rhs.searchText
    }
}

class MonsterSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    var icon: Icon { return Icon(name: "\(id)") }
}

class ItemSearchResult: Decodable, FetchableRecord, Identifiable, IconRepresentable {
    let id: Int
    let name: String
    var iconName: String?
    var iconColor: IconColor?
}

class WeaponSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    var weaponType: WeaponType
    var rarity: Int
    var icon: Icon? { return Icon(name: weaponType.imageName, rarity: rarity) }
}

class ArmorSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    let armorType: Armor.Slot?
    let rarity: Int
    var icon: Icon { return Icon(name: armorType?.iconName ?? "", rarity: rarity) }
}

class QuestSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    var questType: String?
    // TODO: re-use instead of duplicating
    var icon: Icon? {
        switch questType {
        case "hunt": return Icon(name: "quest_hunt")
        case "slay": return Icon(name: "quest_slay")
        case "assignment": return Icon(name: "quest_assignment")
        case "deliver": return Icon(name: "quest_deliver")
        case "capture": return Icon(name: "quest_capture")
        default: return nil
        }
    }
}

class LocationSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    // TODO: re-use instead of duplicating
    var iconName: String {
        switch id {
        case 1: return "location_ancient_forest"
        case 2: return "locations_wildspire_waste"
        case 3: return "locations_coral_highlands"
        case 4: return "locations_rotten_vale"
        case 5: return "locations_elders_recess"
        case 12: return "locations_hoarfrost_reach"
        case 14: return "locations_the_guiding_lands"
        default: return "question_mark"
        }
    }
    var icon: Icon { Icon(name: iconName) }
}

class SkillTreeSearchResult: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    var iconColor: IconColor?
    var icon: Icon { return Icon(name: "armor_skill", color: iconColor) }
}

// Would be nice to separate queries from the objects so we can re-use queries
extension Database {
    func monsters(search: String) -> [MonsterSearchResult] {
        let query = Query(table: "monster")
            .columns(["monster.id", "name"])
            .join(table: "monster_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func items(search: String) -> [ItemSearchResult] {
        let query = Query(table: "item")
            .columns(["item.id", "name", "icon_name", "icon_color"])
            .join(table: "item_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func weapons(search: String) -> [WeaponSearchResult] {
        let query = Query(table: "weapon")
            .columns(["weapon.id", "name", "weapon_type", "rarity"])
            .join(table: "weapon_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func armors(search: String) -> [ArmorSearchResult] {
        let query = Query(table: "armor")
            .columns(["armor.id", "name", "armor_type", "rarity"])
            .join(table: "armor_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func quests(search: String) -> [QuestSearchResult] {
        let query = Query(table: "quest")
            .columns(["quest.id", "name", "quest_type"])
            .join(table: "quest_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func locations(search: String) -> [LocationSearchResult] {
        let query = Query(table: "location_text")
            .columns(["id", "name"])
            .filter("name", contains: search)
        return fetch(query)
    }

    func skilltrees(search: String) -> [SkillTreeSearchResult] {
        let query = Query(table: "skilltree")
            .columns(["skilltree.id", "name", "icon_color"])
            .join(table: "skilltree_text")
            .filter("name", contains: search)
        return fetch(query)
    }
}
