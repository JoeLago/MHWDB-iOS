//
//  GridView.swift
//  MHWDB
//
//  Created by Joe on 8/15/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct GridView: View {
    @State var labels: [[NSAttributedString]]

    var body: some View {
        HStack {
            Spacer()
            VStack {
                ForEach(labels, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { label in
                            AttributedText(label)
                        }
                    }
                }
            }
            Spacer()
        }
    }
}
