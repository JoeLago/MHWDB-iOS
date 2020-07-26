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

    init(_ attributedText: NSAttributedString) {
        self.attributedText = attributedText
    }

    func makeUIView(context: Context) -> UILabel {
        return UILabel()
    }

    func updateUIView(_ label: UILabel, context: Context) {
        label.attributedText = attributedText
    }
}

extension Monster {

    var weaknessAttributedString: NSAttributedString {
        return ImageLabelString(values: [
        ("Fire.png", value: weaknessFire ?? 0),
        ("Water.png", value: weaknessWater ?? 0),
        ("Thunder.png", value: weaknessThunder ?? 0),
        ("Ice.png", value: weaknessIce ?? 0),
        ("Dragon.png", value: weaknessDragon ?? 0),
        ("Poison.png", value: weaknessPoison ?? 0),
        ("Paralysis", value: weaknessParalysis ?? 0),
        ("Sleep.png", value: weaknessSleep ?? 0)
            ]).attributedText
    }
}

class ImageLabelString {
    let imgDim: CGFloat = 20
    let stateFontSize: CGFloat = 16
    let valueFontSize: CGFloat = 14

    var attributedText = NSMutableAttributedString()

    init(values: [(String, Int)]) {
        for pair in values {
            addNonZeroImageValue(icon: Icon(name: pair.0), value: pair.1)
        }
    }

    func addNonZeroImageValue(icon: Icon, value: Int?) {
        if let value = value, value != 0 {
            addImageValue(icon: icon, value: value)
        } else if value == nil {
            addImageValue(icon: icon)
        }
    }

    func addImageValue(icon: Icon, value: Int? = nil) {
        if let attachment = textAttachment(icon: icon, width: imgDim, height: imgDim, fontSize: valueFontSize) {
            attributedText.append(NSAttributedString(attachment: attachment))
        }

        if let value = value {
            attributedText.append(string: "\(value)")
        }

        attributedText.append(string: "  ")
    }

    func textAttachment(icon: Icon, width: CGFloat, height: CGFloat, fontSize: CGFloat) -> NSTextAttachment? {
        guard let image = icon.image else { return nil }
        let font = UIFont.systemFont(ofSize: fontSize)
        let textAttachment = NSTextAttachment()
        textAttachment.image = image
        let mid = font.descender + font.capHeight
        textAttachment.bounds = CGRect(x: 0, y: font.descender - height / 2 + mid + 2, width: width, height: height).integral
        return textAttachment
    }
}
