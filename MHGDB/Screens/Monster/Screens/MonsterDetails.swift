//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class MonsterDetails: DetailController, DetailScreen {
    var id: Int
    
    convenience init(id: Int) {
        self.init(Database.shared.monster(id: id))
    }
    
    init(_ monster: Monster) {
        id = monster.id
        super.init()
        title = monster.name
        addSimpleSection(data: [monster])
        
        addSimpleSection(data: monster.habitats, title: "Habitats") { LocationDetails(id: $0.locationId) }
        addCustomSection(title: "Damage", data: monster.damageByPart, cellType: MonsterDamagesCell.self, showCount: false)
        addRewardSection(monster: monster, rank: .low, title: "Low Rank Rewards")
        addRewardSection(monster: monster, rank: .high, title: "High Rank Rewards")
        addRewardSection(monster: monster, rank: .g, title: "G Rank Rewards")
    }
    
    func addRewardSection(monster: Monster, rank: Quest.Rank, title: String) {
        let rewards = monster.rewardsByCondition(rank: rank)
        let sections = [SimpleDetailSection](rewards.keys.map
        { SimpleDetailSection(data: rewards[$0]!, title: $0, showCountMinRows: -1)
        { self.push(ItemDetails(id: $0.itemId)) } })
        add(section: SubSection(subSections: sections, title: title))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("I don't want to use storyboards Apple")
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
