//
//  MonsterWeaknessView.swift
//  MHWDB
//
//  Created by Joe on 9/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct MonsterWeaknessesView: View {
    let elementValues: [(imageName: String, value: Int?)]
    let statusValues: [(imageName: String, value: Int?)]
    let isAlt: Bool

    init?(monster: Monster, isAlt: Bool) {
        self.isAlt = isAlt
        if !isAlt {
            guard monster.hasWeakness else { return nil }
            elementValues = [
                ("element_fire", monster.weaknessFire),
                ("element_water", monster.weaknessWater),
                ("element_thunder", monster.weaknessThunder),
                ("element_ice", monster.weaknessIce),
                ("element_dragon", monster.weaknessDragon)
            ]
            statusValues = [
                ("status_poison", monster.weaknessPoison),
                ("status_paralysis", monster.weaknessParalysis),
                ("status_sleep", monster.weaknessSleep),
                ("status_blast", monster.weaknessBlast),
                ("status_stun", monster.weaknessStun)
            ]
        } else {
            guard monster.hasAltWeakness else { return nil }
            elementValues = [
                ("element_fire", monster.altWeaknessFire),
                ("element_water", monster.altWeaknessWater),
                ("element_thunder", monster.altWeaknessThunder),
                ("element_ice", monster.altWeaknessIce),
                ("element_dragon", monster.altWeaknessDragon)
            ]
            statusValues = [
                ("status_poison", monster.altWeaknessPoison),
                ("status_paralysis", monster.altWeaknessParalysis),
                ("status_sleep", monster.altWeaknessSleep),
                ("status_blast", monster.altWeaknessBlast),
                ("status_stun", monster.altWeaknessStun)
            ]
        }
    }

    var body: some View {
        StaticCollapsableSection(title: isAlt ? "Weaknesses in Mud" : "Weaknesses") {
            VStack {
                HStack(spacing: 4) {
                    ForEach(elementValues, id: \.0) { (imageName, value) in
                        value.map { value in
                            HStack(spacing: 0) {
                                IconImage(Icon(name: imageName), iconSize: .defaultSmallIconSize)
                                Text("\(value)").font(.singleDetail)
                            }
                        }
                    }
                }
                HStack(spacing: 4) {
                    ForEach(statusValues, id: \.0) { (imageName, value) in
                        value.map { value in
                            HStack(spacing: 0) {
                                IconImage(Icon(name: imageName), iconSize: .defaultSmallIconSize)
                                Text("\(value)").font(.singleDetail)
                            }
                        }
                    }
                }
            }
        }
    }
}
