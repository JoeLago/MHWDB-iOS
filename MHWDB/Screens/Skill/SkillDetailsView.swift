//
//  SkillDetailsSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SkillDetailView: View {
    var skilltree: Skilltree
    var skillArmors: [(String, [SkilltreeArmor])]

    init(id: Int) {
        let skillTree = Database.shared.skilltree(id: id)
        self.skilltree = skillTree

        skillArmors = Armor.Slot.allCases.compactMap {
            let armor = skillTree.armor(slot: $0)
            return ($0.rawValue.capitalized, armor)
        }
    }

    var body: some View {
        List {
            skilltree.description.map { ItemCell(titleText: "Description", subtitleText: $0) }

            CollapsableSection(title: "Skills", data: skilltree.skills) { skill in
                HStack(spacing: 16) {
                    Text("Lv \(skill.level)").font(.subheadline).foregroundColor(Color("accent"))
                    Text(skill.description).font(.subheadline)
                }
            }

            CollapsableSection(title: "Decorations", data: skilltree.decorations) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "+ \($0.skilltreeLevel)",
                    destination: CharmDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Charms", data: skilltree.charms) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "+ \($0.level)",
                    destination: CharmDetailView(id: $0.id)
                )
            }

            ForEach(skillArmors, id: \.0) { item in
                CollapsableSection(title: item.0, data: item.1) {
                    ItemDetailCell(
                        icon: $0.icon,
                        titleText: $0.name,
                        detailText: "+ \($0.level)",
                        destination: ArmorDetailView(id: $0.id)
                    )
                }
            }

            // TODO: Set bonuses
        }
        .navigationBarTitle(skilltree.name)
        .modifier(DetailButtonsModifier())
    }
}
