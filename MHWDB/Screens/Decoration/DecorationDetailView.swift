//
//  DecorationDetailView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct DecorationDetailView: View {
    var decoration: Decoration

    init(id: Int) {
        decoration = Database.shared.decoration(id: id)
    }

    var skillTrees: [(tree: Skilltree, level: Int)] { return [decoration.skilltree, decoration.skillTreeTwo].compactMap { $0 } }

    var body: some View {
        List {
            Section {
                ItemCell(icon: decoration.icon, titleText: "Rarity", detailText: "\(decoration.rarity)")

                ForEach(skillTrees, id: \.tree.id) {
                    ItemDetailCell(
                        titleText: $0.tree.name,
                        subtitleText: $0.tree.description,
                        detailText: "+\($0.level)",
                        destination: SkillDetailView(id: $0.tree.id)
                    )
                }

                CollapsableSection(title: "Drop Rates", data: decoration.feystoneRates) {
                    ItemCell(
                        icon: Icon(name: "items_feystone", color: $0.color),
                        titleText: "\($0.title) Feystone",
                        detailText: "\($0.percentage > 0 ? "\($0.percentage)%" : "-")"
                    )
                }
            }
        }
        .navigationBarTitle(decoration.name)
        .modifier(DetailButtonsModifier())
    }
}
