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
    @State var imageName: String?
    @State var titleText: String?
    @State var subtitleText: String?
    @State var detailText: String?
    var destination: () -> Destination

    init(
        iconSize: CGFloat = 40,
        imageName: String? = nil,
        titleText: String? = nil,
        subtitleText: String? = nil,
        detailText: String? = nil,
        destination: @autoclosure @escaping () -> Destination
    ) {
        _iconSize = .init(initialValue: iconSize)
        _imageName = .init(initialValue: imageName)
        _titleText = .init(initialValue: titleText)
        _subtitleText = .init(initialValue: subtitleText)
        _detailText = .init(initialValue: detailText)
        self.destination = destination
    }

    var body: some View {
        NavigationLink(destination: NavigationLazyView(destination)) {
            HStack {
                imageName.map {
                    Image($0).resizable()
                        .frame(width: iconSize, height: iconSize)
                }
                VStack(alignment: .leading) {
                    titleText.map { Text($0).font(.body) }
                    subtitleText.map { Text($0).font(.caption).foregroundColor(.secondary) }
                }
                Spacer()
                detailText.map { Text($0).font(.body).foregroundColor(Color.Text.secondary) }
            }
        }
    }
}

// TODO: Need to dedup code in this + above class, is it possible to leave out destination with the generic type?
struct ItemCell: View {

    @State var iconSize: CGFloat = 40
    @State var imageName: String?
    @State var titleText: String?
    @State var subtitleText: String?
    @State var detailText: String?

    var body: some View {
        HStack {
            imageName.map {
                Image($0).resizable()
                    .frame(width: iconSize, height: iconSize)
            }
            VStack(alignment: .leading) {
                titleText.map { Text($0).font(.body) }
                subtitleText.map { Text($0).font(.caption).foregroundColor(.secondary) }
            }
            Spacer()
            detailText.map { Text($0).font(.body).foregroundColor(Color.Text.secondary) }
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
