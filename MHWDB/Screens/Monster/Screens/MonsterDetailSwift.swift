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
    var lowRankRewards: [RewardConditions]

    init(monsterId: Int) {
        monster = Database.shared.monster(id: monsterId)
        lowRankRewards = Database.shared.rewardsByReward(monsterId: monster.id, rank: .low)
    }

    var body: some View {
        List() {
            // Could combine the ForEach part into the init
            CollapsableSection(title: "Habitats") {
                ForEach(monster.habitats) {
                    ItemDetailCell(titleText: $0.name, detailText: $0.string, destination: MonsterListSwift())
                }
            }

            if !lowRankRewards.isEmpty {
                CollapsableSection(title: "Low Rank Rewards") {
                    ForEach(lowRankRewards) {
                        RewardCell(imageName: $0.iconName, titleText: $0.name, rewards: $0.conditions)
                    }
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
