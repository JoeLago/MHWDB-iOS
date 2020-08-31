//
//  ArmorSetDetailView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

private let iconSize: CGFloat = 24

struct ArmorSetDetailView: View {
    var armorSet: ArmorSet

    init(id: Int) {
        armorSet = Database.shared.armorSet(id: id)
    }

    var body: some View {
        List {
            CollapsableSection(title: "Pieces", data: armorSet.armor) { armor in
                NavigationLink(destination: NavigationLazyView({ ArmorDetailView(id: armor.id) })) {
                    HStack {
                        IconImage(armor.icon)
                        VStack(alignment: .leading) {
                            Text(armor.name).font(.subheadline)
                            Text("Rarity \(armor.rarity)")
                                .font(.subheadline)
                                .foregroundColor(Color(IconColor(rarity: armor.rarity).color))
                        }

                        Spacer()

                            // Kind of weird way to get label icons left and the values to stick right
                            HStack {
                                VStack(alignment: .leading, spacing: 0) {
                                    IconImage(Icon(name: "defense"), iconSize: iconSize)
                                    IconImage(Icon(name: "slots_blue"), iconSize: iconSize)
                                }
                                VStack(alignment: .trailing, spacing: 0) {
                                    Text(armor.defenseText).font(.caption).frame(height: iconSize)
                                    ArmorSlotsView(armor: armor)
                                }
                            }

                    }
                }
            }

            StaticCollapsableSection(title: "Details") {
                ArmorDetailCellView(iconName: "defense", label: "Defense", value: armorSet.defenseText)
                ArmorDetailCellView(iconName: "element_fire", label: "Vs. Fire", value: "\(armorSet.fire)")
                ArmorDetailCellView(iconName: "element_water", label: "Vs. Water", value: "\(armorSet.water)")
                ArmorDetailCellView(iconName: "element_thunder", label: "Vs. Thunder", value: "\(armorSet.thunder)")
                ArmorDetailCellView(iconName: "element_ice", label: "Vs. Ice", value: "\(armorSet.ice)")
                ArmorDetailCellView(iconName: "element_dragon", label: "Vs. Dragon", value: "\(armorSet.dragon)")
            }

            CollapsableSection(title: "Skills", data: armorSet.skills) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    subtitleText: $0.description,
                    detailText: "+ \($0.level)",
                    destination: SkillDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Components", data: armorSet.components) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity ?? 0)",
                    destination: ItemDetailView(id: $0.itemId)
                )
            }
        }
        .navigationBarTitle("\(armorSet.displayName)")
    }
}

struct ArmorSlotsView: View {
    var armor: Armor

    var body: some View {
        HStack(spacing: 2) {
            IconImage(Icon(name: armor.slot1.iconName), iconSize: iconSize)
            IconImage(Icon(name: armor.slot2.iconName), iconSize: iconSize)
            IconImage(Icon(name: armor.slot3.iconName), iconSize: iconSize)
        }
    }
}
