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
    
    var imageName: String {
        switch self {
        case .fire: return "Fire"
        case .water: return "Water.png"
        case .ice: return "Ice.png"
        case .thunder: return "Thunder.png"
        case .dragon: return "Dragon.png"
        case .paralysis: return "Paralysis.png"
        case .poison: return "Poison.png"
        case .sleep: return "Sleep.png"
        case .slime: return "Slime.png"
        case .blastblight: return "Blastblight.png"
        case .blast: return "Blastblight.png"
        }
    }
}
