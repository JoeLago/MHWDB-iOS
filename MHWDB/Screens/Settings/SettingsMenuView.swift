//
//  SettingsMenuView.swift
//  MHWDB
//
//  Created by Joe on 9/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SettingsMenuView: View {
    @State private var hub = "Assigned"
    @State private var showMenu = false
    private var quests: [(stars: Int, quests: [Quest])] {
        return Database.shared.quests(category: hub.lowercased(), stars: nil)
            .sorted { $0.stars < $1.stars }
    }
    private var hubs: [String]

    @State var showActionSheet: Bool = false
    var actionSheet: ActionSheet {
        ActionSheet(
            title: Text("Quest Type"),
            buttons: hubs.map { hub in
                .default(Text(hub)) { self.hub = hub }
            }
        )
    }

    init() {
        hubs = Database.shared.questCategories().map { $0.capitalizingFirstLetter() }
    }

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                List {
                    ForEach(quests, id: \.stars) { questsForStar in
                        CollapsableSection(
                            title: questsForStar.quests.first.map { Quest.titleForStars(count: $0.stars) } ?? "Unknown",
                            titleColor: questsForStar.quests.first?.rank.color,
                            isCollapsed: true,
                            data: questsForStar.quests
                        ) {
                            ItemDetailCell(
                                icon: $0.icon,
                                titleText: $0.name,
                                destination: QuestDetailView(id: $0.id)
                            )
                        }
                    }
                }

                BottomToolBarView() {
                    Spacer()
                    Button(
                        action: { self.showActionSheet.toggle() },
                        label: { Text(self.hub) }
                    )
                    Spacer()
                }
                .actionSheet(isPresented: $showActionSheet, content: { self.actionSheet })
            }
        }
        .navigationBarTitle("Quests")
    }
}
