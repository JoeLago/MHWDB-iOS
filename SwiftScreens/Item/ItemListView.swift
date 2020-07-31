//
//  ItemListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemListView: View {
    private var items = Database.shared.items()

    var body: some View {
        List(items, id: \.id) {
            ItemDetailCell(
                imageName: $0.icon,
                titleText: $0.name,
                destination: ItemDetailView(id: $0.id)
            )
        }
        .navigationBarTitle("Items")
    }
}
