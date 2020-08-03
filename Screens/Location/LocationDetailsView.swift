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

    init(id: Int) {
        location = Database.shared.location(id: id)
    }

    var body: some View {
        List() {
            // TODO: Map Cell

            CollapsableSection(title: "Monsters", data: location.monsters) { monster in
                ItemDetailCell(
                    imageName: monster.icon,
                    titleText: monster.name,
                    subtitleText: monster.areas,
                    destination: MonsterDetailView(id: monster.id)
                )
            }

            // TODO: Low Rank Rewards
            // TODO: High Rank Rewards
            // TODO: G Rank Rewards
        }
        .navigationBarTitle(location.name)
    }
}
