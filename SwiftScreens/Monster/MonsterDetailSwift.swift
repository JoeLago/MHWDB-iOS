//
//  MonsterDetailSwif.swift
//  MHWDB
//
//  Created by Joe on 10/21/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MonsterDetailSwift: View {
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
                    destination: MonsterListSwift()
                )
            }

            // TODO: Damages
            // TODO: Statuses

            StaticCollapsableSection(title: "Weaknesses") {
                AttributedText(monster.weaknessAttributedString)
            }

            if !monster.lowRankRewards.isEmpty {
                CollapsableSection(title: "Low Rank Rewards", data: monster.lowRankRewards) {
                    RewardCell(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
                }
            }

            if !monster.highRankRewards.isEmpty {
                CollapsableSection(title: "High Rank Rewards", data: monster.highRankRewards) {
                    RewardCell(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
                }
            }

            if !monster.gRankRewards.isEmpty {
                CollapsableSection(title: "G Rank Rewards", data: monster.gRankRewards) {
                    RewardCell(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
                }
            }
        }
        .navigationBarTitle(monster.name)
    }
}
