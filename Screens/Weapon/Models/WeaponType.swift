//
//  WeaponType.swift
//  MHGDB
//
//  Created by Joe on 5/8/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation

enum WeaponType: String, Decodable {
    case greatSword = "great-sword"
    case longSword = "long-sword"
    case swordAndShield = "sword-and-shield"
    case dualBlades = "dual-blades"
    case hammer = "hammer"
    case huntingHorm = "hunting-horn"
    case lance = "lance"
    case gunlance = "gunlance"
    case switchAxe = "switch-axe"
    case chargeBlade = "charge-blade"
    case insectGlaive = "insect-glaive"
    case lightBowgun = "light-bowgun"
    case heavyBowgun = "heavy-bowgun"
    case bow = "bow"
    case unknown = "Unknown"

    static var allValues: [WeaponType] {
        return [.greatSword, .longSword, .swordAndShield, .dualBlades, .hammer, .huntingHorm,
                .lance, .gunlance, .switchAxe, .chargeBlade, .insectGlaive, .lightBowgun, .heavyBowgun,
                .bow]
    }

    var imagePrefix: String {
        switch self {
        case .greatSword: return "great_sword"
        case .longSword: return "long_sword"
        case .swordAndShield: return "sword_and_shield"
        case .dualBlades: return "dual_blades"
        case .hammer: return "hammer"
        case .huntingHorm: return "hunting_horn"
        case .lance: return "lance"
        case .gunlance: return "gunlance"
        case .switchAxe: return "switch_axe"
        case .chargeBlade: return "charge_blade"
        case .insectGlaive: return "insect_glaive"
        case .lightBowgun: return "light_bowgun"
        case .heavyBowgun: return "heavy_bowgun"
        case .bow: return "bow"
        case .unknown: return ""
        }
    }

    var imageName: String {
        switch self {
        case .greatSword: return "great_sword8"
        case .longSword: return "long_sword2"
        case .swordAndShield: return "sword_and_shield3"
        case .dualBlades: return "dual_blades4"
        case .hammer: return "hammer5"
        case .huntingHorm: return "hunting_horn6"
        case .lance: return "lance7"
        case .gunlance: return "gunlance8"
        case .switchAxe: return "switch_axe9"
        case .chargeBlade: return "charge_blade10"
        case .insectGlaive: return "insect_glaive2"
        case .lightBowgun: return "light_bowgun3"
        case .heavyBowgun: return "heavy_bowgun4"
        case .bow: return "bow5"
        case .unknown: return ""
        }
    }

    var displayName: String {
        switch self {
        case .greatSword: return "Great Sword"
        case .longSword: return "Long Sword"
        case .swordAndShield: return "Sword and Shield"
        case .dualBlades: return "Dual Blades"
        case .hammer: return "Hammer"
        case .huntingHorm: return "Hunting Horn"
        case .lance: return "Lance"
        case .gunlance: return "Gunlance"
        case .switchAxe: return "Switch Axe"
        case .chargeBlade: return "Charge Blade"
        case .insectGlaive: return "Insect Glaive"
        case .lightBowgun: return "Light Bowgun"
        case .heavyBowgun: return "Heavy Bowgun"
        case .bow: return "Bow"
        case .unknown: return ""
        }
    }
}