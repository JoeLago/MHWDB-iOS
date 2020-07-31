//
//  ImageLabelSwift.swift
//  MHWDB
//
//  Created by Joe on 7/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct ImageLabelSwift: View {
    var iconSize: CGFloat = 40
    var imageName: String?
    var text: String

    var body: some View {
        HStack {
            imageName.map {
                Image($0).resizable()
                .frame(width: iconSize, height: iconSize)
            }
            Text(text).font(.body)
        }
    }
}
