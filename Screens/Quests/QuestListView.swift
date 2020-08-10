//
//  QuestListView.swift
//  MHWDB
//
//  Created by Joe on 8/3/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct QuestListView: View {

    @State private var hub = "Assigned"
    private var quests: [(stars: Int, quests: [Quest])] {
        return Database.shared.quests(category: hub.lowercased(), stars: nil)
            .sorted { $0.stars < $1.stars }
    }
    private var hubs: [String]

    init() {
        hubs = Database.shared.questCategories().map { $0.capitalizingFirstLetter() }
    }

    var body: some View {
        VStack(spacing: 0) {
            List {
                ForEach(quests, id: \.stars) { questsForStar in
                    CollapsableSection(
                        title: Quest.titleForStars(count: questsForStar.stars),
                        isCollapsed: true,
                        data: questsForStar.quests
                    ) {
                        ItemDetailCell(
                            imageName: $0.icon,
                            titleText: $0.name,
                            destination: QuestDetailView(id: $0.id)
                        )
                    }
                }
            }

            BottomToolBarView() {
                Spacer()
                Text(hub)
                .contextMenu { // TODO: Want a regular tap, need to fix
                    ForEach(hubs, id: \.self) { hub in
                        Button(
                            action: { self.hub = hub },
                            label: { Text(hub) }
                        )
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle("Quests")
    }
}
