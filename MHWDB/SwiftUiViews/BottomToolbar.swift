//
//  BottomToolbar.swift
//  MHWDB
//
//  Created by Joe on 10/20/19.
//  Copyright © 2019 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct BottomToolBarView<Content>: View where Content: View {

    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        VStack {
            Divider()
            HStack {
                content
            }
            .padding()
        }
        .background(
            Color.barBackground
                .opacity(0.98)
                //.blur(radius: 5) // ends up having rounded edges, not the translucent look of navigation bar
                .edgesIgnoringSafeArea(.all)
        )
    }
}
