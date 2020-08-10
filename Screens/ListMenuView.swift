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
    var body: some View {
        NavigationView {
            List {
                ItemDetailCell(imageName: "17", titleText: "Monsters", destination: MonsterListView())
                ItemDetailCell(icon: Icon(name: "icon_quest", color: .red), titleText: "Quests", destination: QuestListView())
                ItemDetailCell(icon: Icon(name: "icon_great_sword", color: .cyan), titleText: "Weapons", destination: WeaponTypeListView())
                ItemDetailCell(icon: Icon(name: "icon_armor_body", color: .pink), titleText: "Armor", destination: ArmorSetListView())
                ItemDetailCell(icon: Icon(name: "icon_ore", color: .purple), titleText: "Items", destination: ItemListView())
                ItemDetailCell(icon: Icon(name: "icon_liquid", color: .green), titleText: "Combinations", destination: CombinationListView())
                ItemDetailCell(icon: Icon(name: "icon_map_icon", color: .white), titleText: "Locations", destination: LocationListView())
                ItemDetailCell(icon: Icon(name: "icon_quest", color: .teal), titleText: "Charms", destination: CharmListView())
                ItemDetailCell(icon: Icon(name: "icon_jewel", color: .cyan), titleText: "Decorations", destination: DecorationListView())
                ItemDetailCell(icon: Icon(name: "icon_monster_jewel", color: .teal), titleText: "Skills", destination: SkillListView())
            }
            .navigationBarTitle("MHWDB")
        }.onAppear {
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
