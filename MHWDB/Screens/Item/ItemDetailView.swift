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
                ItemCell(titleText: "Description", subtitleText: item.description)
                HStack(spacing: 16) {
                    ValueView(name: "Stack", value: item.stack, icon: Icon(name: "item_box"))
                    Spacer()
                    ValueView(name: "Buy", value: item.buy, icon: Icon(name: "zenny"))
                    Spacer()
                    ValueView(name: "Sell", value: item.sell, icon: Icon(name: "zenny"))
                }
            }

            CollapsableSection(title: "Craft", data: item.combinations) {
                CombinationView(combination: $0)
            }

            CollapsableSection(title: "Locations", data: item.locations) {
                ItemDetailCell(
                    titleText: [$0.rank, $0.name].compactMap({ $0 }).joined(separator: " "),
                    subtitleText: $0.area.map { "Area \($0)" },
                    detailText: "\($0.stack ?? 0 > 1 ? "x\($0.stack ?? 0) ": "")\($0.percentage ?? 0)%",
                    destination: LocationDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Monster Rewards", data: item.monsters) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: "\($0.rank.rawValue) \($0.name)",
                    subtitleText: "\($0.condition)",
                    detailText: "\($0.stack > 1 ? "x\($0.stack) ": "")\($0.percentage)%",
                    destination: MonsterDetailView(id: $0.monsterId)
                )
            }

            CollapsableSection(title: "Quest Rewards", data: item.quests) {
                ItemDetailCell(
                    icon: $0.quest.icon,
                    titleText: "\($0.quest.name)\($0.stack > 1 ? " (x\($0.stack))" : "")",
                    subtitleText: "\($0.quest.rank.rawValue) \($0.quest.stars)\(String.star) \($0.quest.questType?.capitalized ?? "")",
                    detailText: "\($0.percentage)%",
                    destination: QuestDetailView(id: $0.questId)
                )
            }

            CollapsableSection(title: "Armor", data: item.armor) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "\($0.quantity)",
                    destination: ArmorDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Weapons", data: item.weapons) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "\($0.quantity)",
                    destination: WeaponDetailView(id: $0.id)
                )
            }

            CollapsableSection(title: "Charms", data: item.charms) {
                ItemDetailCell(
                    icon: $0.icon,
                    titleText: $0.name,
                    detailText: "\($0.quantity)",
                    destination: CharmDetailView(id: $0.id)
                )
            }
        }
        .navigationBarTitle(item.name)
        .modifier(DetailButtonsModifier())
    }
}
