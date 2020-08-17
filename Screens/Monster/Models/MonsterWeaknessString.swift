//
//  MonsterStatImages.swift
//  MHWDB
//
//  Created by Joe on 8/15/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation

// TODO: using old icons for most of these

extension Monster {
    var weaknessAttributedString: NSAttributedString {
        return ImageValueString(values: [
            ImageValue("element_fire", weaknessFire),
            ImageValue("element_water", weaknessWater),
            ImageValue("element_thunder", weaknessThunder),
            ImageValue("element_ice", weaknessIce),
            ImageValue("element_dragon", weaknessDragon),
            ImageValue("status_poison", weaknessPoison),
            ImageValue("status_paralysis", weaknessParalysis),
            ImageValue("status_sleep", weaknessSleep),
            ImageValue("status_blast", weaknessBlast),
            ImageValue("status_stun", weaknessStun)
        ]).attributedText
    }

    var weaknessAltAttributedString: NSAttributedString? {
        guard hasAltWeakness else { return nil }
        return ImageValueString(values: [
            ImageValue("element_fire", altWeaknessFire),
            ImageValue("element_water", altWeaknessWater),
            ImageValue("element_thunder", altWeaknessThunder),
            ImageValue("element_ice", altWeaknessIce),
            ImageValue("element_dragon", altWeaknessDragon),
            ImageValue("status_poison", altWeaknessPoison),
            ImageValue("status_paralysis", altWeaknessParalysis),
            ImageValue("status_sleep", altWeaknessSleep),
            ImageValue("status_blast", altWeaknessBlast),
            ImageValue("status_stun", altWeaknessStun)
        ]).attributedText
    }
}
