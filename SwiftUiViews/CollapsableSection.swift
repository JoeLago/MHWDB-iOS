//
//  CollapsableSection.swift
//  MHWDB
//
//  Created by Joe on 10/21/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CollapsableSection<Content>: View where Content: View {

    let title: String
    @State var isCollapsed = false
    let content: Content

    public init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        Section(header:
            CustomeHeader(title: title, isCollapsed: isCollapsed)
            .onTapGesture { self.isCollapsed.toggle() }) {
                if !isCollapsed {
                    content
                }
            }
    }
}

struct CustomeHeader: View {
    let title: String
    @State var isCollapsed = false

    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(isCollapsed ? "+" : "-")
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        .padding()
        .background(Color.Background.header)
    }
}
