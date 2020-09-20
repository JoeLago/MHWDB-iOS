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
            StaticCollapsableSection(title: "Details") {
                SingleDetailView(iconName: "defense", label: "Defense", value: armor.defenseText)
                SingleDetailView(iconName: "slots_blue", label: "Slots") { SocketsView(armor: armor) }
                SingleDetailView(iconName: "element_fire", label: "Vs. Fire", value: "\(armor.fire)")
                SingleDetailView(iconName: "element_water", label: "Vs. Water", value: "\(armor.water)")
                SingleDetailView(iconName: "element_thunder", label: "Vs. Thunder", value: "\(armor.thunder)")
                SingleDetailView(iconName: "element_ice", label: "Vs. Ice", value: "\(armor.ice)")
                SingleDetailView(iconName: "element_dragon", label: "Vs. Dragon", value: "\(armor.dragon)")
            }

            CollapsableSection(title: "Skills", data: armor.skills) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    subtitleText: $0.description,
                    detailText: "+ \($0.level)",
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
        // Would like if we could set the min row height on the detail section only
        .environment(\.defaultMinListRowHeight, 22)
        .navigationBarTitle("\(armor.name)")
        .modifier(DetailButtonsModifier())
    }
}
