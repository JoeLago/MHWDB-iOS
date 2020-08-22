//
//  ImageIcon.swift
//  MHWDB
//
//  Created by Joe on 8/9/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct IconImage: View {
    var icon: Icon
    var iconSize: CGFloat

    init(_ icon: Icon, iconSize: CGFloat = 40) {
        self.icon = icon
        self.iconSize = iconSize
    }

    var body: some View {
        Image(icon.name).resizable()
            .colorMultiply((icon.color.map { Color($0) }) ?? .white)
            .frame(width: iconSize, height: iconSize)
    }
}

protocol IconRepresentable {
    var iconName: String? { get }
    var iconColor: IconColor? { get }
}

extension IconRepresentable {
    var icon: Icon {
        return Icon(
            name: iconName.map { "items_\($0)".lowercased() },
            color: iconColor
        )
    }
}

// TODO: Used default svg conversion to png makes many icons have black color in the wront parts.

struct Icon {
    let name: String
    let color: UIColor?
    // enum class IconType like Android?

    init(name: String, rarity: Int) {
        self.name = name
        self.color = IconColor(rarity: rarity).color
    }

    init(name: String?, color: IconColor? = nil) {
        self.name = name ?? "question_mark"
        self.color = (color ?? .white).color
    }

    var image: UIImage? {
        guard var image = UIImage(named: name) else { return nil }
        if let color = color {
            image = image.tint(color)
        }
        return image
    }
}

extension Icon: Equatable {
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
}
