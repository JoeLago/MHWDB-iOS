//
//  ItemDetailSwift.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemDetailView: View {
    var item: Item

    init(id: Int) {
        item = Database.shared.item(id: id)
    }

    var body: some View {
        List {
            Section {
                HStack(spacing: 16) {
                    // Probably need a different view for these
                    item.stack.map { ItemCell(titleText: "Stack", detailText: "\($0)") }
                    item.buy.map { ItemCell(titleText: "Buy", detailText: "\($0)") }
                    item.sell.map { ItemCell(titleText: "Sell", detailText: "\($0)") }
                }
                ItemCell(titleText: "Description", subtitleText: item.description)
            }

            CollapsableSection(title: "Locations", data: item.locations) {
                ItemDetailCell(
                    titleText: [$0.rank, $0.name].compactMap({ $0 }).joined(separator: " "),
                    subtitleText: $0.nodeName,
                    detailText: "\($0.stack ?? 0 > 1 ? "x\($0.stack ?? 0) ": "")\($0.percentage ?? 0)%",
                    destination: ItemDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Rewards", data: item.monsters) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: "\($0.rank.rawValue) \($0.name)",
                    subtitleText: "\($0.condition)",
                    detailText: "\($0.stack > 1 ? "x\($0.stack) ": "")\($0.chance)%",
                    destination: MonsterDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Armor", data: item.armor) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity)",
                    destination: ArmorDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Weapons", data: item.weapons) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity)",
                    destination: ItemDetailView(id: $0.id) // TODO
                )
            }

            CollapsableSection(title: "Charms", data: item.charms) {
                ItemDetailCell(
                    imageName: $0.icon,
                    titleText: $0.name,
                    detailText: "x \($0.quantity)",
                    destination: DecorationDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle(item.name)
    }
}
