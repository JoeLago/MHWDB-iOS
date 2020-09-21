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
    case huntingHorn = "hunting-horn"
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
        return [.greatSword, .longSword, .swordAndShield, .dualBlades, .hammer, .huntingHorn,
                .lance, .gunlance, .switchAxe, .chargeBlade, .insectGlaive, .lightBowgun, .heavyBowgun,
                .bow]
    }

    var imageName: String {
        switch self {
        case .greatSword: return "equipment_greatsword"
        case .longSword: return "equipment_longsword"
        case .swordAndShield: return "equipment_sword_and_shield"
        case .dualBlades: return "equipment_dual_blades"
        case .hammer: return "equipment_hammer"
        case .huntingHorn: return "equipment_hunting_horn"
        case .lance: return "equipment_lance"
        case .gunlance: return "equipment_gunlance"
        case .switchAxe: return "equipment_switch_axe"
        case .chargeBlade: return "equipment_charge_blade"
        case .insectGlaive: return "equipment_insect_glaive"
        case .lightBowgun: return "equipment_light_bowgun"
        case .heavyBowgun: return "equipment_heavy_bowgun"
        case .bow: return "equipment_bow"
        case .unknown: return ""
        }
    }

    var displayListIcon: Icon {
        return Icon(name: "\(imageName)", rarity: displayListRarity)
    }

    var displayListRarity: Int {
        switch self {
        case .greatSword: return 8
        case .longSword: return 2
        case .swordAndShield: return 3
        case .dualBlades: return 4
        case .hammer: return 5
        case .huntingHorn: return 6
        case .lance: return 7
        case .gunlance: return 8
        case .switchAxe: return 9
        case .chargeBlade: return 10
        case .insectGlaive: return 2
        case .lightBowgun: return 3
        case .heavyBowgun: return 4
        case .bow: return 5
        case .unknown: return 1
        }
    }

    var displayName: String {
        switch self {
        case .greatSword: return "Great Sword"
        case .longSword: return "Long Sword"
        case .swordAndShield: return "Sword and Shield"
        case .dualBlades: return "Dual Blades"
        case .hammer: return "Hammer"
        case .huntingHorn: return "Hunting Horn"
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
