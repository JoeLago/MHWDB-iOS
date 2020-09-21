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
        Image(icon.name).resizable()
            .colorMultiply((icon.color.map { $0 }) ?? .white)
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
        self.name = name
        self.color = Color(IconColor(rarity: rarity).color)
    }

    init(name: String?, color: IconColor? = nil) {
        self.name = name ?? "question_mark"
        self.color = Color((color ?? .white).color)
    }

    private init(name: String, color: Color? = .primary) {
        self.name = name
        self.color = color
    }
}

typealias StyleSafeIcon = Icon
extension StyleSafeIcon {
    init(name: String) {
        self.init(name: name, color: .primary)
    }
}

extension Icon: Equatable {
    public static func == (lhs: Icon, rhs: Icon) -> Bool {
        return lhs.name == rhs.name && lhs.color == rhs.color
    }
}
