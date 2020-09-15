//
//  DecorationListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct DecorationListView: View {
    private var decorations = Database.shared.decorations()

    var body: some View {
        List(decorations, id: \.id) {
            ItemDetailCell(
                icon: $0.icon,
                titleText: $0.name,
                subtitleText: $0.skillTrees.map({ $0.tree.name }).joined(separator: "\n"),
                destination: DecorationDetailView(id: $0.id)
            )
        }
        .navigationBarTitle("Decorations")
    }
}
