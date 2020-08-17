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
            ImageValue("Fire.png", weaknessFire),
            ImageValue("Water.png", weaknessWater),
            ImageValue("Thunder.png", weaknessThunder),
            ImageValue("Ice.png", weaknessIce),
            ImageValue("Dragon.png", weaknessDragon),
            ImageValue("Poison.png", weaknessPoison),
            ImageValue("Paralysis", weaknessParalysis),
            ImageValue("status_sleep.png", weaknessSleep),
            ImageValue("status_blast.png", weaknessBlast),
            ImageValue("Stun.png", weaknessStun)
        ]).attributedText
    }

    var weaknessAltAttributedString: NSAttributedString? {
        guard hasAltWeakness else { return nil }
        return ImageValueString(values: [
            ImageValue("Fire.png", altWeaknessFire),
            ImageValue("Water.png", altWeaknessWater),
            ImageValue("Thunder.png", altWeaknessThunder),
            ImageValue("Ice.png", altWeaknessIce),
            ImageValue("Dragon.png", altWeaknessDragon),
            ImageValue("Poison.png", altWeaknessPoison),
            ImageValue("Paralysis", altWeaknessParalysis),
            ImageValue("status_sleep.png", altWeaknessSleep),
            ImageValue("status_blast.png", altWeaknessBlast),
            ImageValue("Stun.png", altWeaknessStun)
        ]).attributedText
    }
}
