//
//  CharmSkill.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class CharmSkill: FetchableRecord, Decodable {
    var id: Int
    var name: String
    var description: String?
    var level: Int
    var icon: String?
}

extension Database {
    func charmSkills(charmId: Int) -> [CharmSkill] {
        let query = Query(table: "charm_skill")
            .join(table: "skilltree_text", on: "skilltree_id", addLanguageFilter: true)
            .filter("charm_id", equals: charmId)
        return fetch(query)
    }
}
