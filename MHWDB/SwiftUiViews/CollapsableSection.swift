//
//  CollapsableSection.swift
//  MHWDB
//
//  Created by Joe on 10/21/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

// TODO: would be nice if we could pass in the id path instead of requiring Identifiable
struct CollapsableSection<Data, Header, Content>: View where
        Data: RandomAccessCollection,
        Data.Element: Identifiable,
        Header: View,
        Content: View {

    let headerView: (Bool) -> Header
    @State var isCollapsed = false
    let data: Data
    let dataContent: (Data.Element) -> Content

    // Seems like there should be able to do this without anyview?
    var body: some View {
        if !data.isEmpty {
            Section(
                header: headerView(isCollapsed)
                    .contentShape(Rectangle())
                    .onTapGesture { withAnimation { self.isCollapsed.toggle() } }
                    .modifier(NoCaps14())
            ) {
                if !isCollapsed {
                    ForEach(data) {
                        self.dataContent($0)
                    }
                }
            }
        }
    }
}

extension CollapsableSection where Header == CustomeHeader {
    init(title: String, titleColor: UIColor? = nil, isCollapsed: Bool = false, data: Data, dataContent: @escaping (Data.Element) -> Content) {
        self.init(
            headerView: { isCollapsed in CustomeHeader(title: title, titleColor: titleColor, isCollapsed: isCollapsed) },
            isCollapsed: isCollapsed,
            data: data,
            dataContent: dataContent
        )
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
        Section(
            header: CustomeHeader(title: title, titleColor: nil, isCollapsed: isCollapsed)
                .contentShape(Rectangle())
                .onTapGesture { withAnimation { self.isCollapsed.toggle() } }
                .modifier(NoCaps14())
        ) {
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
    }
}

// is there a better way to do this?
struct NoCaps14: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 14, *) {
            return AnyView(content.textCase(.none))
        } else {
            return AnyView(content)
        }
    }
}
