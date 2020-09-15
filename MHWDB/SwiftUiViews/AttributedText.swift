//
//  ImageLabelStackView.swift
//  MHWDB
//
//  Created by Joe on 1/20/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct AttributedText: UIViewRepresentable {
    var attributedText: NSAttributedString
    var alignment: NSTextAlignment

    init(_ attributedText: NSAttributedString, alignment: NSTextAlignment = .left) {
        self.attributedText = attributedText
        self.alignment = alignment
    }

    func makeUIView(context: Context) -> UILabel {
        return UILabel()
    }

    func updateUIView(_ label: UILabel, context: Context) {
        label.attributedText = attributedText
        label.textAlignment = alignment
    }
}
