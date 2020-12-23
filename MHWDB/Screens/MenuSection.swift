//
//  MenuSection.swift
//  MHWDB
//
//  Created by Joe on 12/12/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MenuSection: View {
    @ObservedObject var search: AllSearchObservable

    var body: some View {
        if search.results == nil {
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
        }
    }
}
