//
//  MonsterStatImages.swift
//  MHWDB
//
//  Created by Joe on 8/15/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation

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
            ImageValue("Sleep.png", weaknessSleep),
            ImageValue("Blast.png", weaknessBlast),
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
            ImageValue("Sleep.png", altWeaknessSleep),
            ImageValue("Blast.png", altWeaknessBlast),
            ImageValue("Stun.png", altWeaknessStun)
        ]).attributedText
    }
}
