//
//  CollapsableSection.swift
//  MHWDB
//
//  Created by Joe on 10/21/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

// TODO: would be nice if we could pass in the id path instead of requiring Identifiable
struct CollapsableSection<Data, Content>: View where Data: RandomAccessCollection, Data.Element: Identifiable, Content: View {

    let title: String
    let titleColor: UIColor?
    @State var isCollapsed = false
    let data: Data
    let dataContent: (Data.Element) -> Content

    public init(title: String, titleColor: UIColor? = nil, isCollapsed: Bool = false, data: Data, dataContent: @escaping (Data.Element) -> Content) {
        self.title = title
        self.titleColor = titleColor
        _isCollapsed = .init(initialValue: isCollapsed)
        self.data = data
        self.dataContent = dataContent
    }

    // Seems like there should be able to do this without anyview?
    var body: some View {
        guard data.count > 0 else { return AnyView(EmptyView()) }

        return AnyView(Section(header:
            CustomeHeader(title: title, titleColor: titleColor, isCollapsed: isCollapsed)
            .onTapGesture { self.isCollapsed.toggle() }
        ) {
            if !isCollapsed {
                ForEach(data) {
                    self.dataContent($0)
                }
            }
        })
    }
}

struct StaticCollapsableSection<Content>: View where Content: View {

    let title: String
    @State var isCollapsed = false
    let content: Content

    public init(title: String, isCollapsed: Bool = false, @ViewBuilder content: () -> Content) {
        self.title = title
        _isCollapsed = .init(initialValue: isCollapsed)
        self.content = content()
    }

    var body: some View {
        Section(header:
            CustomeHeader(title: title, titleColor: nil, isCollapsed: isCollapsed)
            .onTapGesture {
                self.isCollapsed.toggle()
            }) {
                if !isCollapsed {
                    content
                }
            }
    }
}

struct CustomeHeader: View {
    let title: String
    let titleColor: UIColor?
    var isCollapsed = false

    var body: some View {
        HStack {
            titleColor.map { Text(title).foregroundColor(Color($0)) } ?? Text(title)
            Spacer()
            Text(isCollapsed ? "+" : "-")
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding()
        .background(Color.Background.header)
    }
}
