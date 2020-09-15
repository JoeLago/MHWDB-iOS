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
    @State var titleText: String?
    @State var subtitleText: String?
    @State var detailText: String?
    var destination: () -> Destination

    init(
        iconSize: CGFloat = 40,
        imageName: String?,
        titleText: String? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil,
        destination: Destination
    ) {
        self.init(
            iconSize: iconSize,
            icon: Icon(name: imageName),
            titleText: titleText,
            subtitleText: subtitleText,
            detailText: detailText,
            destination: destination
        )
    }

    init(
        iconSize: CGFloat = 40,
        icon: Icon? = nil,
        titleText: String? = nil,
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
                icon.map { IconImage($0) }
                VStack(alignment: .leading) {
                    titleText.map { Text($0).font(.body) }
                    subtitleText.map { Text($0).font(.caption).foregroundColor(.secondary) }
                }
                Spacer()
                detailText.map { Text($0).font(.body).foregroundColor(.secondary) }
            }
        }
    }
}

// TODO: Need to dedup code in this + above class, is it possible to leave out destination with the generic type?
struct ItemCell: View {

    @State var iconSize: CGFloat = 40
    @State var imageName: String?
    @State var icon: Icon?
    @State var titleText: String?
    @State var subtitleText: String?
    @State var detailText: String?

    var body: some View {
        HStack {
            imageName.map {
                Image($0).resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            icon.map { IconImage($0) }
            VStack(alignment: .leading) {
                titleText.map { Text($0).font(.body) }
                subtitleText.map { Text($0).font(.caption).foregroundColor(.secondary) }
            }
            Spacer()
            detailText.map { Text($0).font(.body).foregroundColor(.secondary) }
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
