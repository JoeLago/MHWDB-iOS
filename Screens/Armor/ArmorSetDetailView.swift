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
            CollapsableSection(title: "Pieces", data: armorSet.armor) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    destination: ArmorDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle("\(armorSet.displayName)")
    }
}
