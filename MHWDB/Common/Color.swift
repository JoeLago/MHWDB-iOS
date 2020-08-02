//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import SwiftUI
import UIKit

extension Color {
    struct Background {
        static let bar = Color("background_bar")
        static let header = Color("background_header")
    }

    struct Text {
        static let secondary = Color("text_secondary")
    }
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

    static func colorForRarity(_ rarity: Int) -> UIColor {
        switch rarity {
        case 1, 2: return UIColor(hex: 0xCAC8C6)
        case 3: return UIColor(hex: 0xA9B978)
        case 4: return UIColor(hex: 0x6AAC85)
        case 5: return UIColor(hex: 0x7CC2B1)
        case 6: return UIColor(hex: 0x757DFF)
        case 7: return UIColor(hex: 0x7B61AE)
        case 8: return UIColor(hex: 0xB58377)
        default:  return UIColor(hex: 0xCAC8C6)
        }
    }
}

enum IconColor: String, Decodable {
    case beige = "Beige"
    case blue = "Blue"
    case cyan = "Cyan"
    case darkBeige = "DarkBeige"
    case darkGreen = "DarkGreen"
    case darkPurple = "DarkPurple"
    case darkRed = "DarkRed"
    case gold = "Gold"
    case gray = "Gray"
    case green = "Green"
    case khaki = "Khaki"
    case lightBeige = "LightBeige"
    case lime = "Lime"
    case orange = "Orange"
    case red = "Red"
    case violet = "Violet"
    case white = "White"
    case yellow = "Yellow"

    var color: UIColor {
        switch self {
        case .beige: return UIColor(hex: 0x3f63a5) // FIX
        case .blue: return UIColor(hex: 0x3f63a5)
        case .cyan: return UIColor(hex: 0x48A0B3)
        case .darkBeige: return UIColor(hex: 0x324C27) // FIX
        case .darkGreen: return UIColor(hex: 0x324C27) // FIX
        case .darkPurple: return UIColor(hex: 0x324C27)
        case .darkRed: return UIColor(hex: 0x781D38)
        case .gold: return UIColor(hex: 0xC4AB80)
        case .gray: return UIColor(hex: 0x929090)
        case .green: return UIColor(hex: 0x6AAC85)
        case .khaki: return UIColor(hex: 0x8B7E69) // FIX
        case .lightBeige: return UIColor(hex: 0x8B7E69)
        case .lime: return UIColor(hex: 0x8B7E69) // FIX
        case .orange: return UIColor(hex: 0xAE5D40)
        case .red: return UIColor(hex: 0x9A3548)
        case .violet: return UIColor(hex: 0x757DFF)
        case .white: return UIColor(hex: 0xCCCCCC)
        case .yellow: return UIColor(hex: 0xAFBB11)
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
