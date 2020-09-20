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
            monster.description.map { ItemCell(titleText: "Description", subtitleText: $0) }

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

            monster.hitzones.nonEmpty.map { hitzones in
                StaticCollapsableSection(title: "Damage") {
                    MonsterHitzoneView(hitzones: hitzones)
                }
            }

            monster.breaks.nonEmpty.map { breaks in
                StaticCollapsableSection(title: "Breaks") {
                    MonsterHitzoneView(breaks: breaks)
                }
            }

            CollapsableSection(title: "Ailments", data: monster.ailments) {
                Text($0)
            }

            CollapsableSection(title: "Low Rank Rewards", data: monster.lowRankRewards) {
                MonsterRewardView(icon: $0.icon, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "High Rank Rewards", data: monster.highRankRewards) {
                MonsterRewardView(icon: $0.icon, titleText: $0.name, rewards: $0.conditions)
            }

            CollapsableSection(title: "Master Rank Rewards", data: monster.gRankRewards) {
                MonsterRewardView(icon: $0.icon, titleText: $0.name, rewards: $0.conditions)
            }
        }
        .navigationBarTitle(monster.name)
        .modifier(DetailButtonsModifier())
    }
}
