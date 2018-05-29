//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Item: Decodable, RowConvertible {
    let id: Int
    var name: String
    var description: String?
    var icon: String?
    let stack: Int?
    let buy: Int?
    let sell: Int?
    let rarity: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, description, icon, stack = "carry_limit", buy = "buy_price", sell = "sell_price", rarity
    }

    lazy var quests: [ItemQuest] = { return Database.shared.rewards(itemId: self.id) }()
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
