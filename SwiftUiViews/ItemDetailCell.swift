//
//  ItemDetailCell.swift
//  MHWDB
//
//  Created by Joe on 10/20/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemDetailCell<Destination>: View where Destination: View {
    let iconSize: CGFloat = 40

    @State var imageName: String?
    @State var titleText: String?
    @State var subtitleText: String?
    @State var detailText: String?
    var destination: Destination?

    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                imageName.map {
                    Image($0).resizable()
                        .frame(width: iconSize, height: iconSize)
                }
                VStack {
                    titleText.map { Text($0).font(.body) }
                    subtitleText.map { Text($0).font(.body) }
                }
                Spacer()
                detailText.map { Text($0).font(.body).foregroundColor(Color.Text.secondary) }
            }
        }
    }
}
