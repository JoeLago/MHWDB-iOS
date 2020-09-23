//
//  ListMenuSwift.swift
//  MHWDB
//
//  Created by Joe on 10/17/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI
import UIKit
import SwiftlySearch

struct ListMenuView: View {
    @ObservedObject var search = AllSearchObservable()

    var body: some View {
        NavigationView {
            List {
                if search.searchText.isEmpty {
                    Group {
                    ItemDetailCell(
                        icon: Icon(name: "17"),
                        titleText: Text("Monsters"),
                        destination: MonsterListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "quest_assignment"),
                        titleText: Text("Quests"),
                        destination: QuestListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "equipment_greatsword", color: .cyan),
                        titleText: Text("Weapons"),
                        destination: WeaponTypeListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "equipment_armor_set", color: .pink),
                        titleText: Text("Armor"),
                        destination: ArmorSetListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "items_ore", color: .darkBlue),
                        titleText: Text("Items"),
                        destination: ItemListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "items_liquid", color: .green),
                        titleText: Text("Combinations"),
                        destination: CombinationListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "map", color: .white),
                        titleText: Text("Locations"),
                        destination: LocationListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "equipment_charm", color: .orange),
                        titleText: Text("Charms"),
                        destination: CharmListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "decoration_3", color: .cyan),
                        titleText: Text("Decorations"),
                        destination: DecorationListView()
                    )
                    ItemDetailCell(
                        icon: Icon(name: "armor_skill", color: .violet),
                        titleText: Text("Skills"),
                        destination: SkillListView()
                    )
                    }
                    Group {
                    ItemDetailCell(
                        icon: Icon(name: "mascot"),
                        titleText: Text("About"),
                        destination: AboutView()
                    )
                    }
                } else {
                    SearchSectionView(search: search)
                }
            }
            .navigationBarSearch(.init(get: { search.searchText }, set: { search.searchText = $0 }))
            .keyboardObserving()
            .navigationBarTitle("MHWDB")
        }
        .onAppear {
            ReviewManager.presentReviewControllerIfElligible()
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
