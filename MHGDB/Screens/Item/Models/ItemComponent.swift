//
//  ItemComponent.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ItemComponent: RowConvertible, Decodable {
    var id: Int
    var producedId: Int
    var name: String
    var icon: String
    var quantity: Int
}

extension Database {
    func armor(itemId: Int) -> [ItemComponent] {
        let query = """
        SELECT *,
        created.name AS createdname,
        created.icon_name AS createdicon,
        created._id as itemid
        FROM armor
        LEFT JOIN components ON armor._id = components.created_item_id
        LEFT JOIN items AS created on components.created_item_id = created._id
        LEFT JOIN items ON components.component_item_id = items._id
        WHERE items._id == \(itemId)
        """
        return fetch(query)
    }
    
    func weapons(itemId: Int) -> [ItemComponent] {
        let query = "SELECT *,"
            + " created.name AS createdname,"
            + " created.icon_name AS createdicon,"
            + " created._id as itemid"
            + " FROM weapons"
            + " LEFT JOIN components ON weapons._id = components.created_item_id"
            + " LEFT JOIN items AS created on components.created_item_id = created._id"
            + " LEFT JOIN items ON components.component_item_id = items._id"
            + " WHERE items._id == \(itemId)"
        return fetch(query)
    }
    
    func decorations(itemId: Int) -> [ItemComponent] {
        let query = "SELECT *,"
            + " created.name AS createdname,"
            + " created.icon_name AS createdicon,"
            + " created._id as itemid"
            + " FROM decorations"
            + " LEFT JOIN components ON decorations._id = components.created_item_id"
            + " LEFT JOIN items AS created on components.created_item_id = created._id"
            + " LEFT JOIN items ON components.component_item_id = items._id"
            + " WHERE items._id == \(itemId)"
        return fetch(query)
    }
}
