//
//  ArmorSetListView.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ArmorSetListView: View {

    @State private var rankSelection = 0
    private var rank: Quest.Rank? {
        switch rankSelection {
        case 0: return .low
        case 1: return .high
        case 2: return .g
        default: return nil
        }
    }

    @State private var typeSelection: Int = 3
    private var type: Int? { return typeSelection <= 1 ? typeSelection : nil }

    private var armorSets: [ArmorSet] { return Database.shared.armorSet(rank: rank, hrArmorType: type) }

    var body: some View {
        VStack(spacing: 0) {

            List(armorSets) { armorSet in
                // TODO: If it's one piece we should just go to it?
                // TODO: Show all slots
                // TODO: Show defense (per piece maybe? They should always match?)
                NavigationLink(destination: ArmorSetDetailView(id: armorSet.id)) {
                    HStack(spacing: -25) {
                        Text(armorSet.displayName).font(.body)
                        Spacer()
                        ForEach(armorSet.armor) { piece in
                            Image(piece.icon).resizable().frame(width: 40, height: 40)
                        }
                    }
                }
            }

            BottomToolBarView() {
                VStack(alignment: .center, spacing: 16) {
                    HStack {
                        // TODO: Would be nice to persist selection
                        Spacer()
                        Picker(selection: $rankSelection, label: Text("")) {
                            Text("Low").tag(0)
                            Text("High").tag(1)
                            Text("Master").tag(2)
                        }.pickerStyle(SegmentedPickerStyle())
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        // TODO: Should only show for high/g
                        Picker(selection: $typeSelection, label: Text("")) {
                            Text("All").tag(3)
                            Text("α").tag(0)
                            Text("β").tag(1)
                        }.pickerStyle(SegmentedPickerStyle())
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("Armor Sets")
    }
}
