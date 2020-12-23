//
//  Search.swift
//  MHGDB
//
//  Created by Joe on 5/28/17.
//  Copyright © 2017 Gathering Hall Studios. All rights reserved.
//

import Combine
import Foundation

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
            .debounce(for: .seconds(0.2), scheduler: DispatchQueue.global(qos: .background))
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
            let items = Database.shared.items(search: searchText)
            return SearchResponse(searchText: searchText, items: items)
        }

        // Each of these should be a publisher that we combine, should probably make promises out of all db calls in app
        let monsters = Database.shared.monsters(search: searchText)
        let items = Database.shared.items(search: searchText)
        let weapons = Database.shared.weapons(search: searchText)
        let armor = Database.shared.armors(search: searchText)
        let quests = Database.shared.quests(search: searchText)
        let locations = Database.shared.locations(search: searchText)
        let skills = Database.shared.skilltrees(search: searchText)

        return SearchResponse(
            searchText: searchText,
            monsters: monsters,
            items: items,
            weapons: weapons,
            armor: armor,
            quests: quests,
            locations: locations,
            skills: skills
        )
    }
}
