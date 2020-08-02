//
//  LocationListSwift.swift
//  MHWDB
//
//  Created by Joe on 7/25/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct LocationListView: View {
    private var locations = Database.shared.locations()

    var body: some View {
        List(locations, id: \.id) { location in
            ItemDetailCell(
                imageName: location.icon,
                titleText: location.name,
                destination: LocationDetailView(id: location.id)
            )
        }
        .navigationBarTitle("Locations")
    }
}
