//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Decoration: Decodable, FetchableRecord {
    var id: Int
    var name: String
    var icon: String?
    var slotSize: Int
    var glowingFeystoneChance: Double
    var mysteriousFeystoneChance: Double
    var warpedFeystoneChance: Double
    var wornFeystoneChance: Double
    var skilltreeId: Int

    lazy var skillTree: SkillTree = { return Database.shared.skillTree(id: self.skilltreeId) }()

    enum CodingKeys: String, CodingKey {
        case id, name, icon, slotSize = "slot", glowingFeystoneChance, mysteriousFeystoneChance, warpedFeystoneChance, wornFeystoneChance, skilltreeId
    }
}

extension Database {
    func decoration(id: Int) -> Decoration {
        let query = Query(table: "decoration").join(table: "decoration_text").filter(id: id)
        return fetch(query)[0]
    }

    func decorations(_ search: String? = nil) -> [Decoration] {
        let query = Query(table: "decoration").join(table: "decoration_text").order(by: "name")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
