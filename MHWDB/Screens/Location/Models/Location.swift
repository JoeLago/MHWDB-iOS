//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Location: FetchableRecord, Decodable, Identifiable {
    var id: Int
    var name: String

    var icon: Icon { Icon(name: iconName) }

    var iconName: String {
        switch id {
        case 1: return "location_ancient_forest"
        case 2: return "locations_wildspire_waste"
        case 3: return "locations_coral_highlands"
        case 4: return "locations_rotten_vale"
        case 5: return "locations_elders_recess"
        case 12: return "locations_hoarfrost_reach"
        case 14: return "locations_the_guiding_lands"
        default: return "question_mark"
        }
    }

    lazy var monsters: [LocationMonster] = { return Database.shared.locationMonsters(locationId: self.id) }()
    func items(rank: Quest.Rank) -> [LocationItem] { return Database.shared.locationItems(locationId: self.id, rank: rank) }
    lazy var camps: [LocationCamp] = { return Database.shared.locationCamps(locationId: self.id) }()
    lazy var items: [LocationItem] = { return Database.shared.locationItems(locationId: self.id) }()

    lazy var areasGroupedByName: [(area: Int, items: [LocationItem])] = {
        var map = [Int: [LocationItem]]()
        for item in items {
            var locationItems = map[item.area] ?? [LocationItem]()
            locationItems.append(item)
            map[item.area] = locationItems
        }
        return map.map { ($0.key, $0.value) }
    }()

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
        let query = Query(table: "location_text")
            .order(by: "order_id")
        if let search = search { query.filter("name", contains: search) }
        return fetch(query)
    }
}
