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
}
