//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation

class Sharpness {
    static let maxValue = 390.0

    var red = 0
    var orange = 0
    var yellow = 0
    var green = 0
    var blue = 0
    var white = 0
    var purple = 0

    init(palicoSharpness: Int) {
        switch palicoSharpness {
        case 0: orange = 1
        case 1: yellow = 1
        case 2: green = 1
        case 3: blue = 1
        case 4: white = 1
        default: break
        }
    }

    init(string: String, subtracting: Int = 0) {
        var components = string.components(separatedBy: ",")
        guard components.count >= 6  else { return }

        var remaining = subtracting
        for i in (0 ... components.count - 1).reversed() {
            guard remaining > 0 else { break }
            let value = Int(components[i]) ?? 0
            let valueToSubstract = min(remaining, value)
            components[i] = "\(value - valueToSubstract)"
            remaining -= valueToSubstract
        }

        // Make this int enum and loop incrementing int i
        red = Int(components[0]) ?? 0
        orange = Int(components[1]) ?? 0
        yellow = Int(components[2]) ?? 0
        green = Int(components[3]) ?? 0
        blue = Int(components[4]) ?? 0
        white = Int(components[5]) ?? 0
        purple = Int(components[6]) ?? 0
    }
}
