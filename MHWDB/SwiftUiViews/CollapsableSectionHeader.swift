//
//  CollapsableSectionHeader.swift
//  MHWDB
//
//  Created by Joe on 9/20/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct CollapsableSectionHeader: View {
    let title: String
    let titleColor: UIColor?
    var isCollapsed = false

    var body: some View {
        HStack {
            titleColor.map { Text(title).foregroundColor(Color($0)) } ?? Text(title)
            Spacer()
            Text(isCollapsed ? "+" : "-")
        }
        .modifier(HeaderPadding())
    }
}

struct HeaderPadding: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .modifier(CompatibleTextCaseModifier())
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .padding()
    }
}

struct CompatibleTextCaseModifier: ViewModifier {
    @ViewBuilder
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content.textCase(.none)
        } else {
            content
        }
    }
}
