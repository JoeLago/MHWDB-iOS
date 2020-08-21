//
//  SkillTreeItems.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class SkilltreeCharm: FetchableRecord, Decodable, Identifiable {
    let id: Int
    let name: String
    let level: Int
    let rarity: Int

    var icon: Icon { return Icon(name: "equipment_charm", rarity: rarity) }
}

extension Database {
    func skillCharms(skilltreeId: Int) -> [SkilltreeCharm] {
        let query = Query(table: "charm_skill")
            .join(table: "charm", on: "charm_id")
            .join(table: "charm_text", on: "charm_id", addLanguageFilter: true)
            .filter("skilltree_id", equals: skilltreeId)
            .order(by: "level", direction: .dec)
        return fetch(query)
    }
}
