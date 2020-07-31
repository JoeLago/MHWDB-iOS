//
//  LocationDetailsSwift.swift
//  MHWDB
//
//  Created by Joe on 7/25/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct LocationDetailView: View {
    var location: Location

    init(locationId: Int) {
        location = Database.shared.location(id: locationId)
    }

    var body: some View {
        List() {
            // TODO: Map Cell

            CollapsableSection(title: "Monsters", data: location.monsters) { monster in
                ItemDetailCell(
                    imageName: monster.icon,
                    titleText: monster.name,
                    detailText: monster.areas,
                    destination: MonsterDetailView(monsterId: monster.id)
                )
            }

            // TODO: Low Rank Rewards
            // TODO: High Rank Rewards
            // TODO: G Rank Rewards
        }
        .navigationBarTitle(location.name)
    }
}
