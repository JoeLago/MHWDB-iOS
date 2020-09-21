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

            CollapsableSection(title: "Base Camps", data: location.camps) {
                ItemCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "Area \($0.area)"
                )
            }

            CollapsableSection(title: "Monsters", data: location.monsters) {
                ItemDetailCell(
                    icon: Icon(name: $0.icon),
                    titleText: $0.name,
                    subtitleText: $0.areas,
                    destination: MonsterDetailView(id: $0.id)
                )
            }

            ForEach(location.areasGroupedByName.sorted(by: { $0.area < $1.area }), id: \.area) { areaItems in
                CollapsableSection(title: "Area \(areaItems.area)", data: areaItems.items) {
                    ItemDetailCell(
                        icon: $0.icon,
                        titleText: "\($0.name)\(($0.stack ?? 0) > 1 ? " x\($0.stack ?? 0)" : "")",
                        subtitleText: $0.rank?.fullName,
                        detailText: $0.percentage.map { "\($0)%" },
                        destination: ItemDetailView(id: $0.id)
                    )
                }
            }
        }
        .navigationBarTitle(location.name)
    }
}
