//
//  CharmListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CharmListView: View {
    private var charms = Database.shared.charms()

    var body: some View {
        List(charms) {
            ItemDetailCell(
                icon: $0.icon,
                titleText: $0.name,
                destination: CharmDetailView(id: $0.id)
            )
        }
        .navigationBarTitle("Charms")
    }
}
