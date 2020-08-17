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

    init(id: Int) {
        monster = Database.shared.monster(id: id)
    }

    var body: some View {
        List {
            monster.description.map { Text($0).font(.subheadline) }

            CollapsableSection(title: "Habitats", data: monster.habitats) {
                ItemDetailCell(
                    titleText: $0.name,
                    detailText: $0.string,
                    destination: LocationDetailView(id: $0.id)
                )
            }

            if monster.hasWeakness {
                StaticCollapsableSection(title: "Weaknesses") {
                    AttributedText(monster.weaknessAttributedString)
                }
            }

            monster.weaknessAltAttributedString.map { weaknessAltAttributedString in
                StaticCollapsableSection(title: "Weaknesses in Mud") {
                    AttributedText(weaknessAltAttributedString)
                }
            }

            if monster.hitzones.count > 0 {
                StaticCollapsableSection(title: "Damage") {
                    MonsterHitzoneView(hitzones: monster.hitzones)
                }
            }

            CollapsableSection(title: "Ailments", data: monster.ailments) {
                Text($0)
            }

            CollapsableSection(title: "Low Rank Rewards", data: monster.lowRankRewards) {
                MonsterRewardView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "High Rank Rewards", data: monster.highRankRewards) {
                MonsterRewardView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "Master Rank Rewards", data: monster.gRankRewards) {
                MonsterRewardView(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
            }
        }
        .navigationBarTitle(monster.name)
    }
}
