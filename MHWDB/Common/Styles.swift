//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

struct Color {
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
    case white = "White"
    case gray = "Gray"
    case red = "Red"
    case khaki = "Khaki"
    case gold = "Gold"
    case violet = "Violet"
    case blue = "Blue"
    case green = "Green"
    case darkRed = "DarkRed"
    case yellow = "Yellow"
    case cyan = "Cyan"
    case orange = "Orange"
    case darkGreen = "DarkGreen"

    var color: UIColor {
        switch self {
        case .white: return UIColor(hex: 0xCCCCCC)
        case .gray: return UIColor(hex: 0x929090)
        case .red: return UIColor(hex: 0x9A3548)
        case .khaki: return UIColor(hex: 0x8B7E69)
        case .gold: return UIColor(hex: 0xC4AB80)
        case .violet: return UIColor(hex: 0x757DFF)
        case .blue: return UIColor(hex: 0x3f63a5)
        case .green: return UIColor(hex: 0x6AAC85)
        case .darkRed: return UIColor(hex: 0x781D38)
        case .yellow: return UIColor(hex: 0xAFBB11)
        case .cyan: return UIColor(hex: 0x48A0B3)
        case .orange: return UIColor(hex: 0xAE5D40)
        case .darkGreen: return UIColor(hex: 0x324C27)
        }
    }
}

struct Font {
    struct Size {
        static let header: CGFloat = 16
        static let title: CGFloat = 14
        static let subTitle: CGFloat = 12
    }

    static let header = UIFont.systemFont(ofSize: Size.header)
    static let title = UIFont.systemFont(ofSize: Size.title)
    static let titleMedium = UIFont.systemFont(ofSize: Size.title, weight: UIFont.Weight.medium)
    static let titleBold = UIFont.boldSystemFont(ofSize: Size.title)
    static let subTitle = UIFont.systemFont(ofSize: Size.subTitle)
}

extension UIColor {
    convenience init(hex: Int) {
        self.init(red: CGFloat((hex >> 16) & 0xff) / 255.0,
                  green: CGFloat((hex >> 8) & 0xff) / 255.0,
                  blue: CGFloat(hex & 0xff) / 255.0, alpha: 1)
    }
}
