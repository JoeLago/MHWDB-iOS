//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Item: Decodable, FetchableRecord, IconRepresentable {
    let id: Int
    var name: String
    var description: String?
    var iconName: String?
    var iconColor: IconColor?
    let stack: Int?
    let buy: Int?
    let sell: Int?
    let rarity: Int

    enum CodingKeys: String, CodingKey {
        case id, name, description, iconName, iconColor, stack = "carryLimit", buy = "buyPrice", sell = "sellPrice", rarity
    }

    lazy var quests: [QuestReward] = { return Database.shared.itemQuests(itemId: self.id) }()
    lazy var combinations: [Combination] = { return Database.shared.combinations(itemId: self.id) }()
    lazy var locations: [ItemLocation] = { return Database.shared.locations(itemId: self.id) }()
    lazy var monsters: [ItemMonster] = { return Database.shared.itemMonster(itemId: self.id) }()
    lazy var armor: [ItemComponent] = { return Database.shared.armorComponents(itemId: self.id) }()
    lazy var weapons: [ItemComponent] = { return Database.shared.weaponComponents(itemId: self.id) }()
    lazy var charms: [ItemComponent] = { return Database.shared.charmComponents(itemId: self.id) }()
}

extension Database {
    func items(_ search: String? = nil) -> [Item] {
        let query = Query(table: "item").join(table: "item_text")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }

    func item(id: Int) -> Item {
        let query = Query(table: "item").join(table: "item_text").filter(id: id)
        return fetch(query)[0]
    }
}
