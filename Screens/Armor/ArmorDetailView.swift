//
//  ArmorDetailView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ArmorDetailView: View {
    var armor: Armor

    init(id: Int) {
        armor = Database.shared.armor(id: id)
    }

    var body: some View {
        List {
            CollapsableSection(title: "Skills", data: armor.skills) {
                ItemDetailCell(
                    titleText: $0.name,
                    subtitleText: $0.description,
                    detailText: "\($0.level)",
                    destination: SkillDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Components", data: armor.components) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity ?? 0)",
                    destination: ItemDetailView(id: $0.itemId)
                )
            }
        }
        .navigationBarTitle("\(armor.name)")
    }
}
