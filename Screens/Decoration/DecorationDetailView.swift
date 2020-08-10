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
                ItemCell(titleText: "Slot Size", detailText: "\(decoration.skilltreeLevel)")
                VStack {
                    ItemCell(titleText: "Warped", detailText: "\(decoration.warpedFeystonePercent)%")
                    ItemCell(titleText: "Worn", detailText: "\(decoration.wornFeystonePercent)%")
                    ItemCell(titleText: "Glowing", detailText: "\(decoration.glowingFeystonePercent)%")
                    ItemCell(titleText: "Mysterious", detailText: "\(decoration.mysteriousFeystonePercent)%")
                }
            }
        }
        .navigationBarTitle(decoration.name)
    }
}
