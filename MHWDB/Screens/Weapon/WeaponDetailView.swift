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
                // ViewBuilder maxes out at 10 views so we have to split it into groups
                Group {
                    SingleDetailView(iconName: "attack", label: "Attack", value: weapon.attack)
                    SingleDetailView(iconName: "attack", label: "Attack (True)", value: weapon.attackTrue)
                    SingleDetailView(iconName: "affinity", label: "Affinity", value: weapon.affinity, wrap: ({ "\($0)%" }))
                    weapon.element1Attack.map { attack in
                        SingleDetailView(iconName: "element", label: "Element") {
                            ImageLabelView(
                                icon: weapon.element1?.icon,
                                iconSize: .defaultSmallIconSize,
                                text: (weapon.element1?.rawValue ?? "")
                                    // TODO: Need to translate element and "max" which means passing Text() instead
                                    + (weapon.elementHidden ? "  (\(attack))" : "  \(attack)")
                                    + " (\(Weapon.maxDamage(base: attack)) max)",
                                font: .singleDetail,
                                color: weapon.elementHidden ? .muted : .primary
                            )
                        }
                    }
                    // TODO: Need to display like above
                    SingleDetailView(iconName: "element", label: "Element 2", value: weapon.element2Attack)
                    weapon.sockets.map { sockets in
                        SingleDetailView(iconName: "slots_blue", label: "Slots") { SocketsView(sockets: sockets) }
                    }
                    SingleDetailView(iconName: "elderseal", label: "Elderseal", value: weapon.elderseal?.capitalizingFirstLetter() ?? "None")
                    SingleDetailView(iconName: "defense", label: "Defense", value: weapon.defense)

                    weapon.notes.map { notes in
                        SingleDetailView(iconName: "notes", label: "Notes") {
                            HStack {
                                ForEach(Array(notes), id: \.self) {
                                    IconImage(Icon(note: $0, weaponNotes: notes), iconSize: .defaultSmallIconSize)
                                }
                            }
                        }
                    }
                }

                Group {
                    weapon.coatingIcons.map { coatingIcons in
                        SingleDetailView(iconName: "equipment_bow", label: "Coatings") {
                            HStack(spacing: 8) {
                                ForEach(coatingIcons, id: \.self) { coating in
                                    VStack(spacing: 0) {
                                        IconImage(coating.icon, iconSize: .defaultSmallIconSize)
                                        Text(coating.rawValue).font(.caption).foregroundColor(.secondary)
                                    }
                                }
                            }
                        }
                    }

                    SingleDetailView(iconName: "special_ammo", label: "Special Ammo", value: weapon.ammo?.specialAmmo)
                    SingleDetailView(iconName: "deviation", label: "Deviation", value: weapon.ammo?.deviation)
                    weapon.shelling.map {
                        SingleDetailView(iconName: "shelling", label: "Shelling",
                                         value: "\($0.capitalized) Lv \(weapon.shellingLevel ?? 0)")
                    }
                    weapon.phial.map {
                        // TODO: element icon
                        SingleDetailView(iconName: "phials", label: "Phial Type",
                                         value: "\($0.capitalized)\(weapon.phialPower.map { " \($0)" } ?? "" )")
                    }
                    SingleDetailView(iconName: "kinsect_white", label: "Kinsect Bonus", value: weapon.kinsectBonus?.capitalized)

                    weapon.sharpnesses.map { sharpnesses in
                        SingleDetailView(iconName: "whetstone", label: "Sharpness") { SharpnessesView(sharpnesses: sharpnesses) }
                    }
                }
            }

            CollapsableSection(
                headerView: { _ in
                    HStack {
                        Text("Ammo")
                        Spacer()
                        Text("CAP").frame(width: 30).font(.singleDetail)
                        Text("Type+Recoil").frame(width: 100).font(.singleDetail)
                        Text("Reload").frame(width: 60).font(.singleDetail)
                    }
                    .padding(.vertical)
                },
                data: weapon.ammo?.allValues ?? [],
                dataContent: { ammo in
                    HStack {
                        IconImage(ammo.icon, iconSize: .defaultSmallIconSize)
                        Text(ammo.name).font(.singleDetail)
                        Spacer()
                        Text("\(ammo.clip)").font(.singleDetail).foregroundColor(.secondary).frame(width: 30)
                        Text("\(ammo.shotType)\(ammo.recoilString ?? "")").font(.singleDetail).foregroundColor(.secondary).frame(width: 100)
                        Text(ammo.reload?.capitalized ?? "").font(.singleDetail).foregroundColor(.secondary).frame(width: 60)
                    }
                }
            )

            CollapsableSection(title: "Skills", data: weapon.skills) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    subtitleText: $0.description,
                    detailText: "+ \($0.level)",
                    destination: SkillDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Melodies", data: weapon.melodies) {
                MelodyView(melody: $0)
            }

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
        .navigationBarTitle(weapon.name)
        .modifier(DetailButtonsModifier())
    }
}
