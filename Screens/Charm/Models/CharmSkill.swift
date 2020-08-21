//
//  CharmSkill.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

struct CharmSkill: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    var iconColor: IconColor?
    let level: Int

    var icon: Icon { return Icon(name: "armor_skill", color: iconColor) }
}

extension Database {
    func charmSkills(charmId: Int) -> [CharmSkill] {
        let query = Query(table: "charm_skill")
        .join(table: "skilltree", on: "skilltree_id")
            .join(table: "skilltree_text", on: "skilltree_id", addLanguageFilter: true)
            .filter("charm_id", equals: charmId)
        return fetch(query)
    }
}
