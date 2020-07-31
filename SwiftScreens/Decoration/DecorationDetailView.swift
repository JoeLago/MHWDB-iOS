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

    var body: some View {
        List {
            Section {
                // Can't there be multiple skills now?
                ItemDetailCell(
                    titleText: decoration.skillTree.name,
                    subtitleText: decoration.skillTree.description,
                    // do we need to worry about capturing self?
                    destination: SkillDetailView(id: self.decoration.skillTree.id)
                )
                ItemCell(titleText: "Slot Size", detailText: "\(decoration.slotSize)")
                VStack {
                    ItemCell(titleText: "Warped", detailText: "\(decoration.warpedFeystoneChance)%")
                    ItemCell(titleText: "Worn", detailText: "\(decoration.wornFeystoneChance)%")
                    ItemCell(titleText: "Glowing", detailText: "\(decoration.glowingFeystoneChance)%")
                    ItemCell(titleText: "Mysterious", detailText: "\(decoration.mysteriousFeystoneChance)%")
                }
            }
        }
        .navigationBarTitle(decoration.name)
    }
}
