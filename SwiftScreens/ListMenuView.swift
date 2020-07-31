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
                ItemDetailCell(imageName: "great_sword8", titleText: "Weapons", destination: MonsterListView()) // TODO
                ItemDetailCell(imageName: "body4", titleText: "Armor", destination: MonsterListView()) // TODO
                ItemDetailCell(imageName: "Ore-Purple", titleText: "Items", destination: ItemListView())
                ItemDetailCell(imageName: "Liquid-Green", titleText: "Combinations", destination: CombinationListView())
                ItemDetailCell(imageName: "Map-Icon-White", titleText: "Locations", destination: LocationListView())
                ItemDetailCell(imageName: "Quest-Icon-White", titleText: "Charms", destination: CharmListView())
                ItemDetailCell(imageName: "Jewel-Cyan", titleText: "Decorations", destination: DecorationListView())
                ItemDetailCell(imageName: "Monster-Jewel-Teal", titleText: "Skills", destination: SkillListView())
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
