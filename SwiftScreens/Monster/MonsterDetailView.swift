//
//  MonsterDetailSwif.swift
//  MHWDB
//
//  Created by Joe on 10/21/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MonsterDetailView: View {
    var monster: Monster

    init(monsterId: Int) {
        monster = Database.shared.monster(id: monsterId)
    }

    var body: some View {
        List {
            CollapsableSection(title: "Habitats", data: monster.habitats) {
                ItemDetailCell(
                    titleText: $0.name,
                    detailText: $0.string,
                    destination: MonsterListView()
                )
            }

            // TODO: Damages
            // TODO: Statuses

            StaticCollapsableSection(title: "Weaknesses") {
                AttributedText(monster.weaknessAttributedString)
            }

            CollapsableSection(title: "Low Rank Rewards", data: monster.lowRankRewards) {
                RewardCellView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "High Rank Rewards", data: monster.highRankRewards) {
                RewardCellView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "Master Rank Rewards", data: monster.gRankRewards) {
                RewardCellView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }
        }
        .navigationBarTitle(monster.name)
    }
}
