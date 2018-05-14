//
//  ArmorSet.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSet: RowConvertible, Decodable {
    let id: Int
    let name: String
    
    lazy var armor: [Armor] = { return Database.shared.armorSetPieces(armorSetId: id) }()
}

extension Database {
    func armorSet(id: Int) -> ArmorSet {
        let query = Query(table: "armorset").join(table: "armorset_text")
        return fetch(query)[0]
    }
    
    func armorSet(_ search: String? = nil) -> [ArmorSet] {
        let query = Query(table: "armorset").join(table: "armorset_text")
        return fetch(query)
    }
}
