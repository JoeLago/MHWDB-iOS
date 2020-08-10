//
//  QuestListView.swift
//  MHWDB
//
//  Created by Joe on 8/3/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct QuestListView: View {

    @State private var showingAlert = false
    @State private var hub = "assigned"
    private var quests: [[Quest]] { return Database.shared.quests() }
    private var hubs: [String]

    init() {
        hubs = Database.shared.questCategories()
    }

    var body: some View {
        VStack(spacing: 0) {
//            List(quests[0]) {
//                ItemDetailCell(
//                    imageName: $0.icon,
//                    titleText: $0.name,
//                    destination: QuestDetailView(id: $0.id)
//                )
//            }

            PlaceholderView()
            Spacer()

            BottomToolBarView() {
                Spacer()

                Text("Hub")
                .contextMenu {
                    Button(
                        action: { self.hub = "assigned"},
                        label: { Text("Red") }
                    )

                    Button(action: {
                        self.hub = "assigned"
                    }, label: {
                        Text("Green")
                    })

                    Button(action: {
                        self.hub = "assigned"
                    }, label: {
                        Text("Blue")
                    })
                }

//                Picker(selection: $hub, label: EmptyView()) {
//                    ForEach(hubs, id: \.self) {
//                        Text($0.capitalized).tag($0)
//                    }
//                }.pickerStyle(SegmentedPickerStyle())

                Spacer()
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text("Important message"),
                message: Text("Wear sunscreen"),
                dismissButton: .default(Text("Got it!"))
            )
        }
        .navigationBarTitle("Quests")
    }
}
