//
//  SearchSection.swift
//  MHWDB
//
//  Created by Joe on 9/15/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SearchSectionView: View {
    @ObservedObject var search: AllSearchObservable

    var body: some View {
        search.results.map { results in
        Group {
            CollapsableSection(title: "Monsters", data: results.monsters) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: MonsterDetailView(id: $0.id))
            }

            CollapsableSection(title: "Items", data: results.items) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: ItemDetailView(id: $0.id))
            }

            CollapsableSection(title: "Weapons", data: results.weapons) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: WeaponDetailView(id: $0.id))
            }

            CollapsableSection(title: "Armor", data: results.armor) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: ArmorDetailView(id: $0.id))
            }

            CollapsableSection(title: "Quests", data: results.quests) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: QuestDetailView(id: $0.id))
            }

            CollapsableSection(title: "Locations", data: results.locations) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: LocationDetailView(id: $0.id))
            }

            CollapsableSection(title: "Skills", data: results.skills) {
                ItemDetailCell(icon: $0.icon, titleText: $0.name, destination: SkillDetailView(id: $0.id))
            }
        }.id(UUID())
        }
    }
}

final class AllSearchObservable: ObservableObject {
    @Published var results: SearchResponse?
    var searchRequest: SearchRequest?

    var searchText: String = "" { didSet { update(searchText: searchText) } }
    var currentSearch: String?

    func update(searchText: String) {
        guard !searchText.isEmpty else {
            results = nil
            return
        }
        guard searchText != currentSearch else { return }

        currentSearch = searchText
        searchRequest?.cancel()
        results = SearchResponse()

        searchRequest = SearchRequest(searchText)
        .then {
            self.searchRequest = nil
            self.results = $0
            // TODO: if results are empty we should let user know
        }
    }
}
