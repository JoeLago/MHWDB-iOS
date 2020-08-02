//
//  CharmDetailView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CharmDetailView: View {
    var charm: Charm

    init(id: Int) {
        charm = Database.shared.charm(id: id)
    }

    var body: some View {
        List {
            CollapsableSection(title: "Skills", data: charm.skills) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    subtitleText: $0.description,
                    detailText: "\($0.level)",
                    destination: SkillDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Recipe", data: charm.items) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity)",
                    destination: ItemDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle("\(charm.name)")
    }
}
