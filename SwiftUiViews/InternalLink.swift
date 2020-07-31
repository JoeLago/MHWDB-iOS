//
//  InternalLink.swift
//  MHWDB
//
//  Created by Joe on 7/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

// https://stackoverflow.com/questions/57857516/is-it-possible-to-have-multiple-navigationlinks-per-row-in-a-list-swiftui

struct InternalLink<Content, Destination>: View where Destination: View, Content: View {

    let destination: Destination?
    let content: () -> Content
    @State private var isLinkActive: Bool = false

    init(destination: Destination, title: String = "", @ViewBuilder content: @escaping () -> Content) {
        self.content = content
        self.destination = destination
    }

    var body: some View {
        return ZStack(alignment: .leading) {
            if self.isLinkActive {
                NavigationLink(destination: destination, isActive: $isLinkActive) {
                    Color.clear
                }.frame(height: 0)
            }
            content()
        }
        .onTapGesture {
            self.pushHiddenNavLink()
        }
    }

    func pushHiddenNavLink() {
        self.isLinkActive = true
    }
}
