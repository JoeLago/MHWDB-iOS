//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class WeaponComponent: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let icon: String?
    let type: String?
    let quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "itemId", name, icon, type = "recipeType", quantity
    }
}

extension Database {
    func components(weaponId: Int) -> [WeaponComponent] {
        let query = Query(table: "weapon_recipe")
            .join(table: "item_text", on: "item_id")
            .filter("weapon_id", equals: weaponId)
        return fetch(query)
    }
}