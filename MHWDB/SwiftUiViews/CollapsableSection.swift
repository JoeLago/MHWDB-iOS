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
                    .onTapGesture { withAnimation { self.isCollapsed.toggle() } }
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

extension CollapsableSection where Header == CollapsableSectionHeader {
    init(title: String, titleColor: UIColor? = nil, isCollapsed: Bool = false, data: Data, dataContent: @escaping (Data.Element) -> Content) {
        self.init(
            headerView: { isCollapsed in CollapsableSectionHeader(title: title, titleColor: titleColor, isCollapsed: isCollapsed) },
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
            header: CollapsableSectionHeader(title: title, titleColor: nil, isCollapsed: isCollapsed)
                .contentShape(Rectangle())
                .onTapGesture { withAnimation { self.isCollapsed.toggle() } }
                .modifier(CompatibleTextCaseModifier())
        ) {
            if !isCollapsed {
                content
            }
        }
    }
}
