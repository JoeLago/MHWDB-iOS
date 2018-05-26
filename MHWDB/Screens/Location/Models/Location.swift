//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Location: RowConvertible, Decodable {
    var id: Int
    var name: String
    var icon: String?

    lazy var monsters: [LocationMonster] = { return Database.shared.locationMonsters(locationId: self.id) }()
    func items(rank: Quest.Rank) -> [LocationItem] { return Database.shared.locationItems(locationId: self.id, rank: rank) }

    func itemsByNode(rank: Quest.Rank) -> [String: [LocationItem]] {
        let allItems = Database.shared.locationItems(locationId: self.id, rank: rank)
        var itemsByNode = [String: [LocationItem]]()
        for item in allItems {
            let nodeName = item.nodeName
            var node = itemsByNode[nodeName] ?? [LocationItem]()
            node.append(item)
            itemsByNode[nodeName] = node
        }
        return itemsByNode
    }
}

extension Database {
    func location(id: Int) -> Location {
        let query = Query(table: "location_text").filter(id: id)
        return fetch(query)[0]
    }

    func locations(_ search: String? = nil) -> [Location] {
        let query = Query(table: "location_text").order(by: "name")
        return fetch(query)
    }
}
