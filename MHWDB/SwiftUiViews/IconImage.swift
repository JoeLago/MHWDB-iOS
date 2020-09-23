//
//  ImageIcon.swift
//  MHWDB
//
//  Created by Joe on 8/9/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

extension CGFloat {
    static let defaultSmallIconSize: CGFloat = 24
}

struct IconImage: View {
    var icon: Icon
    var iconSize: CGFloat

    init(_ icon: Icon, iconSize: CGFloat = 40) {
        self.icon = icon
        self.iconSize = iconSize
    }

    var body: some View {
        Image(icon.name)
            .resizable()
            .renderingMode(.original)
            .colorMultiply(icon.color ?? Color(UIColor.white))
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

struct Icon: Identifiable {
    var id: String { return name + (color?.description ?? "") }
    let name: String
    let color: Color?
    // maybe an enum class IconType to make different Icon backgrounds like Android?

    init(name: String, rarity: Int) {
        self.init(name: name, swiftColor: Color(IconColor(rarity: rarity).color))
    }

    init(name: String?, color: IconColor? = nil) {
        self.init(name: name ?? "question_mark", swiftColor: color.map { Color($0.color) })
    }

    // Only called directly for specific cases
    init(name: String, swiftColor: Color? = nil) {
        self.name = name
        self.color = swiftColor
    }
}

extension Icon: Equatable {
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
}
