//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation

enum Element: String, Decodable {
    case fire = "Fire"
    case water = "Water"
    case ice = "Ice"
    case thunder = "Thunder"
    case dragon = "Dragon"
    case paralysis = "Paralysis"
    case poison = "Poison"
    case sleep = "Sleep"
    case slime = "Slime"
    case blastblight = "Blastblight"
    case blast = "Blast"

    var icon: Icon {
        return Icon(name: imageName)
    }

    var imageName: String {
        switch self {
        case .fire: return "element_fire"
        case .water: return "element_water"
        case .ice: return "element_ice"
        case .thunder: return "element_thunder"
        case .dragon: return "element_dragon"
        case .paralysis: return "status_paralysis"
        case .poison: return "status_poison"
        case .sleep: return "status_sleep"
        case .slime: return "status_slime"
        case .blastblight: return "status_blastblight"
        case .blast: return "status_blast"
        }
    }
}
