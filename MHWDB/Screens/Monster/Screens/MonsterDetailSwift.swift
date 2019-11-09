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
            // Could combine the ForEach part into the init
            CollapsableSection(title: "Habitats") {
                ForEach(monster.habitats) {
                    ItemDetailCell(titleText: $0.name, detailText: $0.string, destination: MonsterListSwift())
                }
            }
//            CollapsableSection(title: "Low Rank Rewards") {
//                ForEach(monster.rewardsByCondition(rank: .low)) {
//                    ForEach($0.keys.compactMap)
//                    //ItemDetailCell(titleText: $0.name, detailText: $0.string, destination: MonsterListSwift())
//                }
//            }

        }
        .navigationBarTitle(monster.name)
    }
}

//RewardSection(monster: monster, rank: .low, title: "Low Rank Rewards"),
//
//class RewardSection: SubSection {
//    init(monster: Monster, rank: Quest.Rank, title: String) {
//        let rewards = monster.rewardsByCondition(rank: rank)
//        let sections = rewards.keys.compactMap { key in
//            rewards[key].map { SimpleDetailSection(title: key, data: $0, showCountMinRows: -1, viewController: {
//                ItemDetails(id: $0.itemId)
//            }) } ?? nil
//        }
//        super.init(subSections: sections, title: title)
//    }
//}
//
//extension MonsterReward: DetailCellModel {
//    var primary: String? { return name + (stackSize ?? 0 > 1 ? " x\(stackSize ?? 0)": "") }
//    var imageName: String? { return icon }
//    var secondary: String? { return "\(Int(chance ?? 0))%" }
//}

struct MonsterDetailSwif_Previews: PreviewProvider {
    static var previews: some View {
        MonsterDetailSwift(monsterId: 1)
    }
}
