//
//  QuestDetailView.swift
//  MHWDB
//
//  Created by Joe on 8/3/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct QuestDetailView: View {
    var quest: Quest

    init(id: Int) {
        quest = Database.shared.quest(id: id)
    }

    var body: some View {
        List {
            CollapsableSection(title: "Monsters", data: quest.monsters) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    destination: MonsterDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle(quest.name ?? "Quest")
    }
}
