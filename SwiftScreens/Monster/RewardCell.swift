//
//  RewardCell.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

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
        }.padding([.vertical], 3)
    }
}
