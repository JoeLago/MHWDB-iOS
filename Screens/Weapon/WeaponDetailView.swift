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

            Section {
                // TODO: Do we have these values?
                MultiValueView(values: [
                    ("Create Cost", weapon.creationCost),
                    ("Upgrade Cost", weapon.upgradeCost)
                ])

                // TODO: Do we have these values?
                MultiValueView(values: [
                    ("Recoil", weapon.recoil),
                    ("Reload Speed", weapon.reloadSpeed),
                    ("Deviation", weapon.deviation),
                    ("Shelling Type", weapon.shellingType)
                ])

                weapon.phial.map {
                    ItemCell(
                        titleText: "Phial",
                        detailText: "\($0.capitalized)\(weapon.phialAttack.map({" \($0)"}) ?? "")"
                    )
                }

                // TODO: Charges are not a thing in MHW?
                weapon.charges.map {
                    ItemCell(
                        titleText: "Charges",
                        detailText: $0.components(separatedBy: "|").joined(separator: ", ")
                    )
                }

                weapon.noteImageNames.map { imageNames in
                    HStack(spacing: 8) {
                        Text("Notes").font(.body)
                        Spacer()
                        ForEach(imageNames, id: \.self) { imageName in
                            Image(imageName).resizable().frame(width: 40, height: 40)
                        }
                    }
                }

                // TODO: Songs

                // TODO: Coatings need to be loaded differently in DB
                weapon.coatingImageNames.map { coatings in
                    HStack(spacing: 8) {
                        Text("Coatings").font(.body)
                        Spacer()
                        ForEach(coatings, id: \.self) { imageName in
                            Image(imageName).resizable().frame(width: 40, height: 40)
                        }
                    }
                }
            }

            CollapsableSection(title: "Recipe", data: weapon.components) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity)",
                    destination: ItemDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle("\(weapon.name)")
    }
}
