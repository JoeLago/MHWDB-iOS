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
        .navigationBarTitle("Locations")
    }
}

struct CombinationView: View {
    var combination: Combination

    var body: some View {
        HStack {
            VStack {
                InternalLink(destination: ItemDetailView(id: combination.firstId)) {
                    ImageLabelView(imageName: self.combination.firstIconName, text: self.combination.firstName)
                }
                InternalLink(destination: ItemDetailView(id: combination.secondId)) {
                    ImageLabelView(imageName: self.combination.secondIconName, text: self.combination.secondName)
                }
            }
            Spacer()
            InternalLink(destination: ItemDetailView(id: combination.resultId)) {
                ImageLabelView(imageName: self.combination.resultIconName, text: self.combination.resultName)
            }
        }
    }
}
