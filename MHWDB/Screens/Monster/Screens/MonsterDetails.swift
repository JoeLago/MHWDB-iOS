//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class MonsterDetails: TableController, DetailScreen {
    var id: Int

    convenience init(id: Int) {
        self.init(Database.shared.monster(id: id))
    }

    init(_ monster: Monster) {
        id = monster.id
        super.init()
        title = monster.name
        sections = [
            SimpleDetailSection(data: [monster]),
            SimpleDetailSection(title: "Habitats", data: monster.habitats) { LocationDetails(id: $0.locationId) },
            CustomSection(title: "Damage", data: monster.damageByPart, cellType: MonsterDamagesCell.self, showCount: false),
            RewardSection(monster: monster, rank: .low, title: "Low Rank Rewards"),
            RewardSection(monster: monster, rank: .high, title: "High Rank Rewards"),
            RewardSection(monster: monster, rank: .g, title: "G Rank Rewards")
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("I don't want to use storyboards Apple")
    }
}

class RewardSection: SubSection {
    init(monster: Monster, rank: Quest.Rank, title: String) {
        let rewards = monster.rewardsByCondition(rank: rank)
        let sections = rewards.keys.compactMap { key in
            rewards[key].map { SimpleDetailSection(title: key, data: $0, showCountMinRows: -1, viewController: {
                ItemDetails(id: $0.itemId)
            }) } ?? nil
        }
        super.init(subSections: sections, title: title)
    }
}

extension MonsterReward: DetailCellModel {
    var primary: String? { return name + (stackSize ?? 0 > 1 ? " x\(stackSize ?? 0)": "") }
    var imageName: String? { return icon }
    var secondary: String? { return "\(Int(chance ?? 0))%" }
}

extension MonsterHabitat: DetailCellModel {
    var primary: String? { return name }
    var secondary: String? { return string }
}
