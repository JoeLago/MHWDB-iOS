//
//  ListMenuSwift.swift
//  MHWDB
//
//  Created by Joe on 10/17/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI
import UIKit

struct ListMenuView: View {
    @ObservedObject var search = AllSearchObservable()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $search.searchText)
                List {
                    ItemDetailCell(imageName: "17", titleText: "Monsters", destination: MonsterListView())
                    ItemDetailCell(icon: Icon(name: "quest_assignment"), titleText: "Quests", destination: QuestListView())
                    ItemDetailCell(icon: Icon(name: "equipment_greatsword", color: .cyan), titleText: "Weapons", destination: WeaponTypeListView())
                    ItemDetailCell(icon: Icon(name: "equipment_armor_set", color: .pink), titleText: "Armor", destination: ArmorSetListView())
                    ItemDetailCell(icon: Icon(name: "items_ore", color: .darkBlue), titleText: "Items", destination: ItemListView())
                    ItemDetailCell(icon: Icon(name: "items_liquid", color: .green), titleText: "Combinations", destination: CombinationListView())
                    ItemDetailCell(icon: Icon(name: "map", color: .white), titleText: "Locations", destination: LocationListView())
                    ItemDetailCell(icon: Icon(name: "equipment_charm", color: .orange), titleText: "Charms", destination: CharmListView())
                    ItemDetailCell(icon: Icon(name: "decoration_3", color: .cyan), titleText: "Decorations", destination: DecorationListView())
                    ItemDetailCell(icon: Icon(name: "armor_skill", color: .violet), titleText: "Skills", destination: SkillListView())
                }
            }
            .keyboardObserving()
            .navigationBarTitle("MHWDB")
        }.onAppear {
            ReviewManager.presentReviewControllerIfElligible()
        }
    }
}

final class AllSearchObservable: ObservableObject {
    var searchText: String = "" { didSet { performSearch() }}
    @Published var items = Database.shared.items()
    var searchRequest: SearchRequest?

    func performSearch() {
        searchRequest?.cancel()
        searchRequest = SearchRequest(searchText, itemsOnly: true).then {
            self.searchRequest = nil
            self.items = $0.items
        }
    }
}

struct ListMenuSwift_Previews: PreviewProvider {
    static var previews: some View {
        ListMenuView()
        .environment(\.colorScheme, .dark)
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
    }
}
