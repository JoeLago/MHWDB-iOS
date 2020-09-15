//
//  ArmorSet.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSet: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let rank: Quest.Rank

    var displayName: String {
        return name.replacingOccurrences(of: "Alpha", with: "α").replacingOccurrences(of: "Beta", with: "β")
    }

    lazy var armor: [Armor] = { return Database.shared.armorSetPieces(armorSetId: id) }()

    lazy var defenseBase: Int = { armor.map({ $0.defenseBase }).reduce(0, +) }()
    lazy var defenseMax: Int = { armor.map({ $0.defenseMax }).reduce(0, +) }()
    lazy var defenseAugmentMax: Int = { armor.map({ $0.defenseAugmentMax }).reduce(0, +) }()
    lazy var fire: Int = { armor.map({ $0.fire }).reduce(0, +) }()
    lazy var water: Int = { armor.map({ $0.water }).reduce(0, +) }()
    lazy var thunder: Int = { armor.map({ $0.thunder }).reduce(0, +) }()
    lazy var ice: Int = { armor.map({ $0.ice }).reduce(0, +) }()
    lazy var dragon: Int = { armor.map({ $0.dragon }).reduce(0, +) }()

    // Must be a better way to write this
    // We could at least write a generic combine function passing the key path
    lazy var components: [RecipeComponent] = {
        let allComponents = armor.map({ $0.components }).reduce([], +)
        var components = [RecipeComponent]()
        for component in allComponents {
            if let existing = components.first(where: { $0.id == component.id }) {
                existing.quantity = (existing.quantity ?? 0) + (component.quantity ?? 0)
            } else {
                components.append(component)
            }
        }
        return components.sorted(by: { $0.quantity ?? 0 > $1.quantity ?? 0 })
    }()

    lazy var skills: [ArmorSkill] = {
        let allComponents = armor.map({ $0.skills }).reduce([], +)
        var components = [ArmorSkill]()
        for component in allComponents {
            if let existing = components.first(where: { $0.id == component.id }) {
                existing.level += component.level
            } else {
                components.append(component)
            }
        }
        return components.sorted(by: { $0.level > $1.level })
    }()

    var defenseText: String { return "\(defenseBase) - \(defenseMax) (\(defenseAugmentMax))" }
}

extension Database {
    func armorSet(id: Int) -> ArmorSet {
        let query = Query(table: "armorset")
            .join(table: "armorset_text")
            .filter(id: id)
        return fetch(query)[0]
    }

    // Need the filter data in db
    func armorSet(_ search: String? = nil, rank: Quest.Rank? = nil, hrArmorType: Int? = nil) -> [ArmorSet] {
        let query = Query(table: "armorset")
            .join(table: "armorset_text")

        if let rank = rank {
            query.filter("rank", equals: rank.rawValue)
        }

        // TODO: not positive this works for all languages, should probably be a value in db
        if let hrArmorType = hrArmorType {
            switch hrArmorType {
            case 0: query.filter("name", contains: "α")
            case 1: query.filter("name", contains: "β")
            default: break
            }
        }

        return fetch(query)
    }

    // need to grab recipes for all pieces, grouping also won't return all columns
    // lots of work here, just going to do it in code
    func armorSetRecipeComponents(id recipeId: Int) -> [RecipeComponent] {
        let query = Query(table: "recipe_item")
            .join(table: "item", on: "item_id")
            .join(origin: "item", table: "item_text")
            .filter("recipe_id", equals: recipeId)
            .group(by: "quantity", function: .sum, as: "quantity")
        return fetch(query)
    }
}
