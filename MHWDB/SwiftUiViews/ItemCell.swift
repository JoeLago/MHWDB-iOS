//
//  ItemCell.swift
//  MHWDB
//
//  Created by Joe on 9/23/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

// TODO: Need to dedup code in this + above class, is it possible to leave out destination with the generic type?
struct ItemCell: View {

    @State var iconSize: CGFloat = 40
    @State var icon: Icon?
    @State var titleText: Text?
    @State var subtitleText: String?
    @State var detailText: String?

    init(
        iconSize: CGFloat = 40,
        icon: Icon? = nil,
        titleText: String? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil
    ) {
        self.init(
            iconSize: iconSize,
            icon: icon,
            titleText: titleText.map { Text($0) },
            subtitleText: subtitleText,
            detailText: detailText
        )
    }

    init(
        iconSize: CGFloat = 40,
        icon: Icon? = nil,
        titleText: Text? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil
    ) {
        _iconSize = .init(initialValue: iconSize)
        _icon = .init(initialValue: icon)
        _titleText = .init(initialValue: titleText)
        _subtitleText = .init(initialValue: subtitleText)
        _detailText = .init(initialValue: detailText)
    }

    var body: some View {
        HStack {
            icon.map { IconImage($0, iconSize: iconSize) }
            VStack(alignment: .leading) {
                titleText.map { $0.font(.body) }
                subtitleText.map { Text($0).font(.caption).foregroundColor(.secondary) }
            }
            Spacer()
            detailText.map { Text($0).font(.body).foregroundColor(.secondary) }
        }
    }
}
