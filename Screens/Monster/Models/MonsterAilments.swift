//
//  MonsterAilments.swift
//  MHWDB
//
//  Created by Joe on 8/16/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation

extension Monster {

    var ailments: [String] {
        func value(_ hasValue: Bool?, _ output: String) -> String? {
            return hasValue == true ? output : nil
        }

        let ailments: [String?] = [
            ailmentRoar.map { "Roar (\($0))" },
            ailmentWind.map { "Wind (\($0))" },
            ailmentTremor.map { "Tremor (\($0))" },
            value(ailmentDefensedown, "Defense Down"),
            value(ailmentParalysis, "Paralysis"),
            value(ailmentPoison, "Poison"),
            value(ailmentSleep, "Sleep"),
            value(ailmentStun, "Stun"),
            value(ailmentBleed, "Bleed"),
            value(ailmentMud, "Mud"),
            value(ailmentEffluvia, "Effluvia"),
            value(ailmentFireblight, "FireBlight"),
            value(ailmentIceblight, "IceBlight"),
            value(ailmentThunderblight, "ThunderBlight"),
            value(ailmentWaterblight, "WaterBlight"),
            value(ailmentBlastblight, "BlastBlight"),
            value(ailmentDragonblight, "DragonBlight")
            //value(ailmentRegional, ""),
        ]

        return ailments.compactMap { $0 }
    }
}
