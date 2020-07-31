//
//  CombinationListSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CombinationListSwift: View {
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
                InternalLink(destination: ItemDetailSwift(id: combination.firstId)) {
                    ImageLabelSwift(imageName: self.combination.firstIconName, text: self.combination.firstName)
                }
                InternalLink(destination: ItemDetailSwift(id: combination.secondId)) {
                    ImageLabelSwift(imageName: self.combination.secondIconName, text: self.combination.secondName)
                }
            }
            Spacer()
            InternalLink(destination: ItemDetailSwift(id: combination.resultId)) {
                ImageLabelSwift(imageName: self.combination.resultIconName, text: self.combination.resultName)
            }
        }
    }
}
