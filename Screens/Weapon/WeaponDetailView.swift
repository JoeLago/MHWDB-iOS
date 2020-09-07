//
//  WeaponDetailView.swift
//  MHWDB
//
//  Created by Joe on 8/1/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct WeaponDetailView: View {
    var weapon: Weapon

    init(id: Int) {
        weapon = Database.shared.weapon(id: id)
    }

    var body: some View {
        List {
            StaticCollapsableSection(title: "Details") {
                SingleDetailView(iconName: "attack", label: "Attack", value: weapon.attack)
                SingleDetailView(iconName: "attack", label: "Attack (True)", value: weapon.attackTrue)
                SingleDetailView(iconName: "affinity", label: "Affinity", value: weapon.affinity, wrap: ({ "\($0)%" }))
                weapon.element1Attack.map { attack in
                    SingleDetailView(iconName: "element", label: "Element") {
                        ImageLabelView(
                            icon: weapon.element1?.icon,
                            iconSize: .defaultSmallIconSize,
                            text: (weapon.element1?.rawValue ?? "")
                                + (weapon.elementHidden ? "  (\(attack))" : "  \(attack)")
                                + " (\(Weapon.maxDamage(base: attack)) max)",
                            font: .singleDetail,
                            color: weapon.elementHidden ? .muted : .primary
                        )
                    }
                }
                SingleDetailView(iconName: "element", label: "Element 2", value: weapon.element2Attack)
                weapon.sockets.map { sockets in
                    SingleDetailView(iconName: "slots_blue", label: "Slots") { SocketsView(sockets: sockets) }
                }
                SingleDetailView(iconName: "elderseal", label: "Elderseal", value: weapon.elderseal?.capitalizingFirstLetter() ?? "None")
                SingleDetailView(iconName: "defense", label: "Defense", value: weapon.defense)
                weapon.sharpnesses.map { sharpnesses in
                    SingleDetailView(iconName: "whetstone", label: "Sharpness") { SharpnessesView(sharpnesses: sharpnesses) }
                }
            }

            // TODO: Melodies
            // TODO: Ammo

            ForEach([
                ("Create Materials", weapon.createComponents),
                ("Upgrade Materials", weapon.upgradeComponents)
            ], id: \.0) {
                CollapsableSection(title: $0.0, data: $0.1 ?? []) {
                    ItemDetailCell(
                        icon: $0.icon,
                        titleText: $0.name,
                        detailText: $0.quantity.map { "x \($0)" },
                        destination: ItemDetailView(id: $0.id)
                    )
                }
            }
        }
        // Would like if we could set the min row height on the detail section only
        .environment(\.defaultMinListRowHeight, 22)
        .navigationBarTitle("\(weapon.name)")
    }
}
