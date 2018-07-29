//
//  ArmorSet.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class ArmorSet: FetchableRecord, Decodable {
    let id: Int
    let name: String
    let rank: Quest.Rank

    lazy var armor: [Armor] = { return Database.shared.armorSetPieces(armorSetId: id) }()
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

        return fetch(query)
    }
}
