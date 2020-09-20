//
//  SingleDetailView.swift
//  MHWDB
//
//  Created by Joe on 9/7/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

extension Font {
    static let singleDetail: Font = .subheadline
}

struct SingleDetailView<ValueContent: View>: View {
    var iconName: String
    var label: String
    let value: ValueContent

    init(iconName: String, label: String, @ViewBuilder content: () -> ValueContent) {
        self.iconName = iconName
        self.label = label
        self.value = content()
    }

    var body: some View {
        HStack(alignment: .top) {
            HStack { // To keep label and icon centered vertically since parent stack has top alignment
                IconImage(Icon(name: iconName), iconSize: .defaultSmallIconSize)
                Text(label).font(.singleDetail)
            }
            Spacer()
            self.value
        }
        .listRowInsets(EdgeInsets(top: 6, leading: 22, bottom: 6, trailing: 22))
    }
}

extension SingleDetailView where ValueContent == Text {

    init?(iconName: String, label: String, value: Int?, wrap: ((String) -> String) = { $0 }) {
        guard let value = value, value != 0 else { return nil }
        self.init(iconName: iconName, label: label, value: wrap("\(value)"))
    }

    init?(iconName: String, label: String, value: String?) {
        guard let value = value else { return nil }
        self.init(iconName: iconName, label: label) { Text(value).font(.singleDetail) }
    }
}
