//
//  MonsterListSwift.swift
//  MHWDB
//
//  Created by Joe on 10/17/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MonsterListView: View {

    @State private var monsterTypeSelection = 0
    private var monsterSize: Monster.Size? {
        switch monsterTypeSelection {
        case 0: return .large
        case 1: return .small
        default: return nil
        }
    }

    private var monsters: [Monster] { return Database.shared.monsters(size: monsterSize) }

    var body: some View {
        VStack(spacing: 0) {
            List(monsters) { monster in
                ItemDetailCell(
                    imageName: monster.icon,
                    titleText: monster.name,
                    destination: MonsterDetailView(id: monster.id)
                )
            }
            BottomToolBarView() {
                Spacer()
                Picker(selection: $monsterTypeSelection, label: Text("")) {
                    Text("Large").tag(0)
                    Text("Small").tag(1)
                    Text("All").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                Spacer()
            }
        }
        //.navigationBarItems(trailing: Text("Home"))
        .navigationBarTitle("Monsters")
    }
}

struct MonsterListSwift_Previews: PreviewProvider {
    static var previews: some View {
        MonsterListView()
    }
}
