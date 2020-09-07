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
                ArmorDetailCellView(iconName: "defense", label: "Defense", value: armor.defenseText)
                ArmorDetailCellView(iconName: "slots_blue", label: "Slots", value: "", view: SocketsView(armor: armor))
                ArmorDetailCellView(iconName: "element_fire", label: "Vs. Fire", value: "\(armor.fire)")
                ArmorDetailCellView(iconName: "element_water", label: "Vs. Water", value: "\(armor.water)")
                ArmorDetailCellView(iconName: "element_thunder", label: "Vs. Thunder", value: "\(armor.thunder)")
                ArmorDetailCellView(iconName: "element_ice", label: "Vs. Ice", value: "\(armor.ice)")
                ArmorDetailCellView(iconName: "element_dragon", label: "Vs. Dragon", value: "\(armor.dragon)")
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
        .environment(\.defaultMinListRowHeight, 18) // Not sure if this will hurt the non-detail sections
        .navigationBarTitle("\(armor.name)")
    }
}
