//
//  Search.swift
//  MHGDB
//
//  Created by Joe on 5/28/17.
//  Copyright © 2017 Gathering Hall Studios. All rights reserved.
//

import Combine
import Foundation

struct SearchResponse {
    var searchText: String
    var monsters: [Monster] = []
    var items: [Item] = []
    var weapons: [Weapon] = []
    var armor: [Armor] = []
    var quests: [Quest] = []
    var locations: [Location] = []
    var skills: [Skilltree] = []
}

extension SearchResponse: Equatable {
    static func == (lhs: SearchResponse, rhs: SearchResponse) -> Bool {
        return lhs.searchText == rhs.searchText
    }
}

final class AllSearchObservable: ObservableObject {
    @Published var searchText = ""
    private var cancellable: Cancellable?

    @Published var isLoading = false // Haven't figured out a great way to set this correctly yet
    @Published var results: SearchResponse?
    var searchRequest: SearchRequest?
    var itemsOnly: Bool

    init(itemsOnly: Bool = false) {
        self.itemsOnly = itemsOnly
        self.cancellable = $searchText
            .filter { [weak self] in
                if $0.isEmpty { self?.results = nil }
                return !$0.isEmpty
            }
            .removeDuplicates()
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue.global(qos: .background))
            .map { SearchRequest($0, itemsOnly: self.itemsOnly).search() }
            .filter { $0?.searchText == self.searchText }
            .receive(on: RunLoop.main)
            .assign(to: \.results, on: self)
    }

    func cancel() {
        searchText = ""
    }
}

class SearchRequest {
    let searchText: String
    var itemsOnly: Bool

    init(_ text: String, itemsOnly: Bool = false) {
        self.searchText = text
        self.itemsOnly = itemsOnly
    }

    // TODO: Have a better way to pick sets of data to search
    func search() -> SearchResponse? {
        let searchText = self.searchText

        if itemsOnly {
            let items = Database.shared.items(searchText)
            return SearchResponse(searchText: searchText, items: items)
        }

        // Each of these should be a publisher that we combine, should probably make promises out of all db calls in app
        let monsters = Database.shared.monsters(searchText)
        let items = Database.shared.items(searchText)
        let weapons = Database.shared.weapons(searchText)
        let armor = Database.shared.armor(searchText)
        let quests = Database.shared.quests(searchText)
        let locations = Database.shared.locations(searchText)
        let skills = Database.shared.skilltrees(searchText)

        return SearchResponse(
            searchText: searchText,
            monsters: monsters,
            items: items,
            weapons: weapons,
            armor: armor,
            quests: quests.map({ $0.quests }).reduce([], +),
            locations: locations,
            skills: skills
        )
    }
}
