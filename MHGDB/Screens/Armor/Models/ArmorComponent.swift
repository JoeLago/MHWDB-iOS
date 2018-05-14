//
//  ArmorComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorComponent: RowConvertible, Decodable {
    var itemId: Int
    var name: String
    var icon: String?
    var type: String?
    var quantity: Int?
}

extension Database {
    func armorComponents(armorId: Int) -> [ArmorComponent] {
        let query = "SELECT"
            + " component._id AS componentid,"
            + " component.name AS componentname,"
            + " component.icon_name AS componenticon,"
            + " component.type AS componenttype"
            + " FROM components"
            + " LEFT JOIN items ON components.created_item_id = items._id"
            + " LEFT JOIN items AS component ON components.component_item_id = component._id"
            + " WHERE items._id == \(armorId)"
        return fetch(query)
    }
}
