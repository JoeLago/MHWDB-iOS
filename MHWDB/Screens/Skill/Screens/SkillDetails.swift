//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class SkillDetails: TableController, DetailScreen {
    var id: Int

    convenience required init(id: Int) {
        self.init(skillTree: Database.shared.skillTree(id: id))
    }

    init(skillTree: SkillTree) {
        id = skillTree.id
        super.init()
        title = skillTree.name
        addSimpleSection(data: skillTree.skills, title: "Skills")
        addSimpleSection(data: skillTree.charms, title: "Charms") { CharmDetails(id: $0.id) }
        addSimpleSection(data: skillTree.armor(slot: .head), title: "Head") { ArmorDetails(id: $0.id) }
        addSimpleSection(data: skillTree.armor(slot: .chest), title: "Chest") { ArmorDetails(id: $0.id) }
        addSimpleSection(data: skillTree.armor(slot: .arms), title: "Arms") { ArmorDetails(id: $0.id) }
        addSimpleSection(data: skillTree.armor(slot: .waist), title: "Waist") { ArmorDetails(id: $0.id) }
        addSimpleSection(data: skillTree.armor(slot: .legs), title: "Legs") { ArmorDetails(id: $0.id) }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SkillTreeItem: DetailCellModel {
    var primary: String? { return name }
    var secondary: String? { return "+ \(level)" }
    var imageName: String? { return nil }
}

extension SkillTreeSkill: DetailCellModel {
    var primary: String? { return description }
    var subtitle: String? { return nil }
    var secondary: String? { return "\(level)" }
    var imageName: String? { return icon }
}
