//
//  ListMenuSwift.swift
//  MHWDB
//
//  Created by Joe on 10/17/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI
import UIKit

struct ListMenuSwift: View {
    var body: some View {
        NavigationView {
            List {
                ItemDetailCell(imageName: "17", titleText: "Monsters", destination: MonsterListSwift())
                ItemDetailCell(imageName: "great_sword8", titleText: "Weapons", destination: MonsterListSwift())
                ItemDetailCell(imageName: "body4", titleText: "Armor", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Ore-Purple", titleText: "Items", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Liquid-Green", titleText: "Combinations", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Map-Icon-White", titleText: "Locations", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Quest-Icon-White", titleText: "Charms", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Jewel-Cyan", titleText: "Decorations", destination: MonsterListSwift())
                ItemDetailCell(imageName: "Monster-Jewel-Teal", titleText: "Skills", destination: MonsterListSwift())
            }
            .navigationBarTitle("MHWDB")
        }
    }
}

struct ListMenuSwift_Previews: PreviewProvider {
    static var previews: some View {
        ListMenuSwift()
        .environment(\.colorScheme, .dark)
        .previewDevice(PreviewDevice(rawValue: "iPhone XR"))
    }
}
