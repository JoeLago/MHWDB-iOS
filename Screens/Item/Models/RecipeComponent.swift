//
//  ArmorComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class RecipeComponent: FetchableRecord, Decodable, Identifiable {
    var id: Int { return itemId }
    var itemId: Int
    var name: String
    var icon: String?
    var type: String?
    var quantity: Int?
}

extension Database {
    func recipeComponents(id recipeId: Int) -> [RecipeComponent] {
        let query = Query(table: "recipe_item")
            .join(table: "item", on: "item_id")
            .join(origin: "item", table: "item_text")
            .filter("recipe_id", equals: recipeId)
        return fetch(query)
    }
}
