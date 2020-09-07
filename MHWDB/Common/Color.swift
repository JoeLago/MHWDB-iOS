//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import SwiftUI
import UIKit

extension Color {
    static let barBackground = Color("background_bar")
    static let headerBackground = Color("background_header")
    static let secondary = Color("text_secondary")
    static let muted = secondary
}

struct DepracatedColor {
    struct Text {
        static let primary = UIColor(hex: 0x292E37)
        static let secondary = UIColor(hex: 0x555555)
        static let subHeader = UIColor(hex: 0x5C8D92)
    }

    struct Background {
        static let light = UIColor(hex: 0xF7F9FE)
        static let dark = UIColor(hex: 0x292E37)
        static let branch = UIColor(hex: 0xA9A9A9)
        static let header = UIColor(hex: 0xF7F7F7)
        static let seperator = UIColor(hex: 0xE9E9E9)
    }

    struct Sharpness {
        static let red = UIColor.red
        static let orange = UIColor.orange
        static let yellow = UIColor.yellow
        static let green = UIColor.green
        static let blue = UIColor.blue
        static let white = UIColor.white
        static let purple = UIColor.purple
    }

    static func setDefaults() {
        //UIView.appearance().backgroundColor = lightBackground
    }
}

enum IconColor: String, Decodable {
    case beige = "Beige"
    case blue = "Blue"
    case cyan = "Cyan"
    case darkBeige = "DarkBeige"
    case darkBlue = "DarkBlue"
    case darkGreen = "DarkGreen"
    case darkPurple = "DarkPurple"
    case darkRed = "DarkRed"
    case gold = "Gold"
    case gray = "Gray"
    case green = "Green"
    case lightBeige = "LightBeige"
    case lime = "Lime"
    case orange = "Orange"
    case pink = "Pink"
    case red = "Red"
    case violet = "Violet"
    case white = "White"
    case yellow = "Yellow"

    // Rarity Only
    case dullCyan = "DullCyan"

    // bright-orange is in Android defs but not used?

    // swiftlint:disable cyclomatic_complexity
    init(rarity: Int) {
        switch rarity {
        case 1: self = .gray
        case 2: self = .white
        case 3: self = .lime
        case 4: self = .green
        case 5: self = .dullCyan
        case 6: self = .darkPurple
        case 7: self = .violet
        case 8: self = .orange
        case 9: self = .red
        case 10: self = .blue
        case 11: self = .gold
        case 12: self = .cyan
        default: self = .white
        }
    }

    var color: UIColor {
        switch self {
        case .beige: return UIColor(hex: 0xE8A669)
        case .blue: return UIColor(hex: 0x5e8efc)
        case .cyan: return UIColor(hex: 0x55D1F0)
        case .darkBeige: return UIColor(hex: 0xd4a55a)
        case .darkBlue: return UIColor(hex: 0x4A49D1)
        case .darkGreen: return UIColor(hex: 0x324C27)
        case .darkPurple: return UIColor(hex: 0x58349b)
        case .darkRed: return UIColor(hex: 0x781D38)
        case .gold: return UIColor(hex: 0xEFCD1E)
        case .gray: return UIColor(hex: 0xC2BFBF)
        case .green: return UIColor(hex: 0x6AAC85)
        case .lightBeige: return UIColor(hex: 0xf7d99b) // Android app says this is temp
        case .lime: return UIColor(hex: 0xA9B978)
        case .orange: return UIColor(hex: 0xB58377)
        case .pink: return UIColor(hex: 0xF399A6)
        case .red: return UIColor(hex: 0x9A3548)
        case .violet: return UIColor(hex: 0x9D93E7)
        case .white: return UIColor(hex: 0xF3F3F3)
        case .yellow: return UIColor(hex: 0xE6EE09)
        case .dullCyan: return UIColor(hex: 0x418189)
        }
    }
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0,
                  green: CGFloat((hex >> 8) & 0xff) / 255.0,
                  blue: CGFloat(hex & 0xff) / 255.0, alpha: 1)
    }
}
