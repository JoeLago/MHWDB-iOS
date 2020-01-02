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
        List() {
            CollapsableSection(title: "Habitats", data: monster.habitats) {
                ItemDetailCell(titleText: $0.name, detailText: $0.string, destination: MonsterListSwift())
            }

            // Too much boilerplate, need to figure out how to automatically omit section for empty array
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
                CollapsableSection(title: "Low Rank Rewards", data: monster.gRankRewards) {
                    RewardCell(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
                }
            }
        }
        .navigationBarTitle(monster.name)
    }
}

struct RewardCell: View {

    @State var imageName: String?
    @State var titleText: String?
    @State var rewards: [MonsterReward]

    var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            ItemCell(iconSize: 30, imageName: imageName, titleText: titleText)
            ForEach(rewards) {
                Text("\(($0.stackSize ?? 0 > 1 ? "x\($0.stackSize ?? 0) ": ""))\($0.condition) - \($0.chance ?? 0)%")
            }
        }
    }
}

struct MonsterDetailSwif_Previews: PreviewProvider {
    static var previews: some View {
        MonsterDetailSwift(monsterId: 1)
    }
}
