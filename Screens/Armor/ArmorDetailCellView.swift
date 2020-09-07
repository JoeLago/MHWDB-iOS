//
//  ArmorDetailCellView.swift
//  MHWDB
//
//  Created by Joe on 9/6/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ArmorDetailCellView: View {
    var iconName: String
    var label: String
    var value: String
    var view: SocketsView?

    var body: some View {
        HStack {
            IconImage(Icon(name: iconName), iconSize: 20)
            Text(label).font(.subheadline)
            Spacer()
            Text(value).font(.subheadline)
            view.map { $0 }
        }.frame(height: 18)
    }
}
