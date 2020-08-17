//
//  ImageLabelSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ImageLabelView: View {
    var iconSize: CGFloat = 40
    var icon: Icon?
    var text: String

    var body: some View {
        HStack {
            icon.map { IconImage($0) }
            Text(text).font(.body)
        }
    }
}
