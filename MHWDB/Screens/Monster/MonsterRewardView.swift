//
//  RewardCell.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MonsterRewardView: View {
    @State var icon: Icon?
    @State var titleText: String?
    @State var rewards: [MonsterReward]
    var itemId: Int { rewards.first?.itemId ?? 0 }

    var body: some View {
        VStack(alignment: .trailing, spacing: 3) {
            ItemDetailCell(iconSize: 30, icon: icon, titleText: titleText, destination: ItemDetailView(id: self.itemId))
            ForEach(rewards) {
                Text("\(($0.stackSize ?? 0 > 1 ? "x\($0.stackSize ?? 0) ": ""))\($0.condition) - \($0.chance ?? 0)%")
            }
        }.padding([.vertical], 3)
    }
}
