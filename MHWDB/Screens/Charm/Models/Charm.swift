//
//  Charm.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import GRDB

class Charm: Decodable, RowConvertible {
    var id: Int
    var name: String
    var icon: String?

    lazy var skills: [CharmSkill] = { return Database.shared.charmSkills(charmId: self.id) }()
    lazy var items: [CharmItem] = { return Database.shared.charmItems(charmId: self.id) }()
}

extension Database {
    func charm(id: Int) -> Charm {
        let query = Query(table: "charm").join(table: "charm_text").filter(id: id)
        return fetch(query)[0]
    }

    func charms(_ search: String? = nil) -> [Charm] {
        let query = Query(table: "charm").join(table: "charm_text").order(by: "name")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
