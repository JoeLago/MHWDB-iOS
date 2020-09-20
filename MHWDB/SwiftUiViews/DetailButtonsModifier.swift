//
//  DetailButtonsModifier.swift
//  MHWDB
//
//  Created by Joe on 9/19/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct DetailButtonsModifier: ViewModifier {

    @ViewBuilder
    func body(content: Content) -> some View {
        content
            .navigationBarItems(
                trailing:
                    HStack(spacing: 26) {
                        Button(
                            action: { (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.popToRoot() },
                            label: { Image(systemName: "house.fill") }
                        )
                    }
            )
    }
}
