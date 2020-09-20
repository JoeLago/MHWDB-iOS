//
//  Search.swift
//  MHGDB
//
//  Created by Joe on 5/28/17.
//  Copyright © 2017 Gathering Hall Studios. All rights reserved.
//

import Foundation

struct SearchResponse {
    var monsters: [Monster] = []
    var items: [Item] = []
    var weapons: [Weapon] = []
    var armor: [Armor] = []
    var quests: [Quest] = []
    var locations: [Location] = []
    var skills: [Skilltree] = []
}

class SearchRequest {
    let searchText: String
    var itemsOnly: Bool
    var isCanceled = false
    var cancelBlock: (() -> Void)?

    init(_ text: String, itemsOnly: Bool = false) {
        self.searchText = text
        self.itemsOnly = itemsOnly
    }

    func cancel() {
        isCanceled = true
        DispatchQueue.main.async {
            self.cancelBlock?()
        }
    }

    // TODO: Have a better way to pick sets of data to search
    func search() -> SearchResponse? {
        let searchText = self.searchText

        if itemsOnly {
            let items = Database.shared.items(searchText)
            if self.isCanceled { return nil }
            return SearchResponse(items: items)
        }

        let monsters = Database.shared.monsters(searchText)
        if self.isCanceled { return nil }
        let items = Database.shared.items(searchText)
        if self.isCanceled { return nil }
        let weapons = Database.shared.weapons(searchText)
        if self.isCanceled { return nil }
        let armor = Database.shared.armor(searchText)
        if self.isCanceled { return nil }
        let quests = Database.shared.quests(searchText)
        if self.isCanceled { return nil }
        let locations = Database.shared.locations(searchText)
        if self.isCanceled { return nil }
        let skills = Database.shared.skilltrees(searchText)
        if self.isCanceled { return nil }

        return SearchResponse(
            monsters: monsters,
            items: items,
            weapons: weapons,
            armor: armor,
            quests: quests.map({ $0.quests }).reduce([], +),
            locations: locations,
            skills: skills
        )
    }

    @discardableResult
    func then(_ completed: @escaping (SearchResponse) -> Void) -> SearchRequest {
        DispatchQueue.global(qos: .background).async {
            guard let response = self.search() else {
                return
            }

            DispatchQueue.main.async {
                completed(response)
            }
        }

        return self
    }

    @discardableResult
    func canceled(_ cancelBlock: @escaping () -> Void) -> SearchRequest {
        self.cancelBlock = cancelBlock
        return self
    }
}
