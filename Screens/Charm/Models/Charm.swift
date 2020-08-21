//
//  Charm.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class Charm: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let name: String
    let rarity: Int
    let recipeId: Int?

    var icon: Icon { return Icon(name: "equipment_charm", rarity: rarity) }

    lazy var skills: [CharmSkill] = { return Database.shared.charmSkills(charmId: self.id) }()
    lazy var items: [RecipeComponent] = { self.recipeId.map({ return Database.shared.recipeComponents(id: $0) }) ?? [RecipeComponent]() }()
}

extension Database {
    func charm(id: Int) -> Charm {
        let query = Query(table: "charm").join(table: "charm_text").filter(id: id)
        return fetch(query)[0]
    }

    func charms(_ search: String? = nil) -> [Charm] {
        let query = Query(table: "charm").join(table: "charm_text").order(by: "order_id")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
