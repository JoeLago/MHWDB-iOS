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
                NavigationDetailCell(imageName: "17", titleText: "Monsters", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "great_sword8", titleText: "Weapons", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "body4", titleText: "Armor", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Ore-Purple", titleText: "Items", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Liquid-Green", titleText: "Combinations", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Map-Icon-White", titleText: "Locations", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Quest-Icon-White", titleText: "Charms", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Jewel-Cyan", titleText: "Decorations", destination: MonsterListSwift())
                NavigationDetailCell(imageName: "Monster-Jewel-Teal", titleText: "Skills", destination: MonsterListSwift())
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

struct NavigationDetailCell<Destination>: View where Destination: View {
    let iconSize: CGFloat = 40

    @State var imageName: String
    @State var titleText: String
    var destination: Destination

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(imageName).resizable()
                    .frame(width: iconSize, height: iconSize)
                Text(titleText)
                    .font(.title)
            }
        }
    }
}
