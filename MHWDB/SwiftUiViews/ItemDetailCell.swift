//
//  ItemDetailCell.swift
//  MHWDB
//
//  Created by Joe on 10/20/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ItemDetailCell<Destination>: View where Destination: View {
    @State var iconSize: CGFloat
    @State var icon: Icon?
    @State var titleText: Text?
    @State var subtitleText: String?
    @State var detailText: String?
    var destination: () -> Destination

    init(
        iconSize: CGFloat = 40,
        icon: Icon? = nil,
        titleText: String? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil,
        destination: Destination
    ) {
        self.init(
            iconSize: iconSize,
            icon: icon,
            titleText: titleText.map { Text($0) },
            subtitleText: subtitleText,
            detailText: detailText,
            destination: destination
        )
    }

    init(
        iconSize: CGFloat = 40,
        icon: Icon? = nil,
        titleText: Text? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil,
        destination: @autoclosure @escaping () -> Destination
    ) {
        _iconSize = .init(initialValue: iconSize)
        _icon = .init(initialValue: icon)
        _titleText = .init(initialValue: titleText)
        _subtitleText = .init(initialValue: subtitleText)
        _detailText = .init(initialValue: detailText)
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: NavigationLazyView(destination)) {
            HStack(spacing: 16) {
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
}

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}
