//
//  CombinationListSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CombinationListView: View {
    private var combinations = Database.shared.combinations()

    var body: some View {
        List(combinations, id: \.id) {
            CombinationView(combination: $0)
        }
        .navigationBarTitle("Combinations")
    }
}

struct CombinationView: View {
    var combination: Combination

    var body: some View {
        HStack(alignment: .top) {
            InternalLink(destination: ItemDetailView(id: combination.resultId)) {
                HStack {
                    self.combination.resultIcon.map { IconImage($0) }
                    VStack(alignment: .leading) {
                        Text(self.combination.resultName).font(.body)
                        Text("x\(self.combination.quantity)").font(.body).foregroundColor(.secondary)
                    }
                }
            }
            Spacer()
            VStack(alignment: .trailing) {
                InternalLink(destination: ItemDetailView(id: combination.firstId)) {
                    HStack {
                        Text(self.combination.firstName).font(.footnote)
                        self.combination.firstIcon.map { IconImage($0, iconSize: 30) }
                    }
                }
                InternalLink(destination: ItemDetailView(id: combination.secondId)) {
                    HStack {
                        Text(self.combination.secondName).font(.footnote)
                        self.combination.secondIcon.map { IconImage($0, iconSize: 30) }
                    }
                }
            }
        }
    }
}
