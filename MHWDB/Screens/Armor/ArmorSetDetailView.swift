//
//  ArmorSetDetailView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

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
                                    IconImage(Icon(name: "defense"), iconSize: .defaultSmallIconSize)
                                    IconImage(Icon(name: "slots_blue"), iconSize: .defaultSmallIconSize)
                                }
                                VStack(alignment: .trailing, spacing: 0) {
                                    Text(armor.defenseText).font(.caption).frame(height: .defaultSmallIconSize)
                                    SocketsView(armor: armor)
                                }
                            }

                    }
                }
            }

            StaticCollapsableSection(title: "Details") {
                SingleDetailView(iconName: "defense", label: "Defense", value: armorSet.defenseText)
                SingleDetailView(iconName: "element_fire", label: "Vs. Fire", value: "\(armorSet.fire)")
                SingleDetailView(iconName: "element_water", label: "Vs. Water", value: "\(armorSet.water)")
                SingleDetailView(iconName: "element_thunder", label: "Vs. Thunder", value: "\(armorSet.thunder)")
                SingleDetailView(iconName: "element_ice", label: "Vs. Ice", value: "\(armorSet.ice)")
                SingleDetailView(iconName: "element_dragon", label: "Vs. Dragon", value: "\(armorSet.dragon)")
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
        // Would like if we could set the min row height on the detail section only
        .environment(\.defaultMinListRowHeight, 22)
        .navigationBarTitle("\(armorSet.displayName)")
    }
}
