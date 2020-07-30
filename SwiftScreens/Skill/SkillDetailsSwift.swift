//
//  SkillDetailsSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SkillDetailSwift: View {
    var skillTree: SkillTree
    var skillItems: [(String, [SkillTreeItem])]

    init(id: Int) {
        let skillTree = Database.shared.skillTree(id: id)
        self.skillTree = skillTree

        skillItems = (
            [("Charms", skillTree.charms)]
            + Armor.Slot.allCases.compactMap {
                let armor = skillTree.armor(slot: $0)
                return ($0.rawValue.capitalized, armor)
            })
    }

    var body: some View {
        List {
            CollapsableSection(title: "Skills", data: skillTree.skills) {
                ItemCell(
                    imageName: $0.icon,
                    titleText: $0.description,
                    detailText: "\($0.level)"
                )
            }

            ForEach(skillItems, id: \.0) { item in
                CollapsableSection(title: item.0, data: item.1) {
                    ItemCell(
                        //imageName: $0.icon,
                        titleText: $0.name,
                        detailText: "+ \($0.level)"
                    )
                }
            }
        }
        .navigationBarTitle(skillTree.name)
    }
}
