//
//  ImageValueString.swift
//  MHWDB
//
//  Created by Joe on 8/15/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import UIKit

struct ImageValue {
    var imageName: String
    var value: Int

    init(_ imageName: String, _ value: Int?) {
        self.imageName = imageName
        self.value = value ?? 0
    }
}

class ImageValueString {
    let imgDim: CGFloat = 20
    let stateFontSize: CGFloat = 16
    let valueFontSize: CGFloat = 14

    var attributedText = NSMutableAttributedString()

    init(values: [ImageValue]) {
        for pair in values {
            addNonZeroImageValue(icon: Icon(name: pair.imageName), value: pair.value)
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
