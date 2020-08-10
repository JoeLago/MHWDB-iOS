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
    @State private var showMenu = false
    private var quests: [(stars: Int, quests: [Quest])] {
        return Database.shared.quests(category: hub.lowercased(), stars: nil)
            .sorted { $0.stars < $1.stars }
    }
    private var hubs: [String]

    init() {
        hubs = Database.shared.questCategories().map { $0.capitalizingFirstLetter() }
    }

    var body: some View {
        ZStack {
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
                    Button(
                        action: {
                            withAnimation {
                                self.showMenu = true
                            }
                        }, label: { Text(self.hub) })
                    Spacer()
                }
            }

            // This is bad, can probably do better, replace with Menu in iOS 14
            ZStack {
                BlurView(style: .light)
                .edgesIgnoringSafeArea(.all)
                HStack {
                    Spacer()
                    VStack {
                        Spacer()
                        ForEach(hubs, id: \.self) { hub in
                            Button(
                                action: {
                                    self.hub = hub
                                    withAnimation {
                                        self.showMenu = false
                                    }
                                },
                                label: { Text(hub) }
                            )
                            .padding()
                            .background(Color.secondary)
                            .cornerRadius(25)
                            .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                }
            }
            .isHidden(!showMenu)
        }
        .navigationBarTitle("Quests")
    }
}
