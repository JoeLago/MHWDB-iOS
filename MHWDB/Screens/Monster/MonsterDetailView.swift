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

            MonsterWeaknessesView(monster: monster, isAlt: false)
            MonsterWeaknessesView(monster: monster, isAlt: true)

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

struct MonsterWeaknessesView: View {
    let allValues: [(imageName: String, value: Int?)]
    let isAlt: Bool

    init?(monster: Monster, isAlt: Bool) {
        self.isAlt = isAlt
        if !isAlt {
            guard monster.hasWeakness else { return nil }
            allValues = [
                ("element_fire", monster.weaknessFire),
                ("element_water", monster.weaknessWater),
                ("element_thunder", monster.weaknessThunder),
                ("element_ice", monster.weaknessIce),
                ("element_dragon", monster.weaknessDragon),
                ("status_poison", monster.weaknessPoison),
                ("status_paralysis", monster.weaknessParalysis),
                ("status_sleep", monster.weaknessSleep),
                ("status_blast", monster.weaknessBlast),
                ("status_stun", monster.weaknessStun)
            ]
        } else {
            guard monster.hasAltWeakness else { return nil }
            allValues = [
                ("element_fire", monster.altWeaknessFire),
                ("element_water", monster.altWeaknessWater),
                ("element_thunder", monster.altWeaknessThunder),
                ("element_ice", monster.altWeaknessIce),
                ("element_dragon", monster.altWeaknessDragon),
                ("status_poison", monster.altWeaknessPoison),
                ("status_paralysis", monster.altWeaknessParalysis),
                ("status_sleep", monster.altWeaknessSleep),
                ("status_blast", monster.altWeaknessBlast),
                ("status_stun", monster.altWeaknessStun)
            ]
        }
    }

    var body: some View {
        StaticCollapsableSection(title: isAlt ? "Weaknesses in Mud" : "Weaknesses") {
            HStack(spacing: 4) {
                ForEach(allValues, id: \.0) { (imageName, value) in
                    value.map { value in
                        HStack(spacing: 0) {
                            IconImage(Icon(name: imageName), iconSize: .defaultSmallIconSize)
                            Text("\(value)").font(.singleDetail)
                        }
                    }
                }

            }
        }
    }
}
