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
            StaticCollapsableSection(title: "Details") {
                Text([
                        "\(quest.stars)\(String.star)",
                        quest.rank.fullName,
                        quest.category?.capitalized,
                        quest.questType?.capitalized
                    ].compactMap({ $0 }).joined(separator: " "))
                quest.objective.map { Text($0) }
                quest.description.map { ItemCell(titleText: Text("Description"), subtitleText: $0) }
                ItemDetailCell(
                    icon: Icon(name: quest.location.iconName),
                    titleText: quest.location.name,
                    destination: LocationDetailView(id: quest.location.id)
                )
            }

            CollapsableSection(title: "Monsters", data: quest.monsters) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    // Might be nicer to just make the name bold
                    subtitleText: $0.isObjective ? "Objective" : nil,
                    // Would be nice to put locations? Query needs to get fixed
                    //subtitleText: $0.locations,
                    detailText: "x\($0.quantity)",
                    destination: MonsterDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Rewards", data: quest.rewards) {
                ItemDetailCell(
                    icon: $0.item.icon,
                    titleText: "\($0.item.name)\($0.stack > 1 ? " x\($0.stack)" : "")",
                    detailText: "\($0.percentage)%",
                    destination: ItemDetailView(id: $0.itemId)
                )
            }
        }
        .navigationBarTitle(quest.name)
        .modifier(DetailButtonsModifier())
    }
}
