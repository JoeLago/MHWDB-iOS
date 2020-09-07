//
//  WeaponCellView.swift
//  MHWDB
//
//  Created by Joe on 8/31/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct WeaponCellView: View {
    @State var weapon: Weapon

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 2) {
                Text(weapon.name).font(.body)
                HStack(spacing: 4) {
                    WeaponValueView(iconNamed: "attack", value: weapon.attack)
                    WeaponValueView(iconNamed: weapon.element1?.imageName, value: weapon.element1Attack, isMuted: weapon.elementHidden)
                    WeaponValueView(iconNamed: weapon.element2?.imageName, value: weapon.element2Attack, isMuted: weapon.elementHidden)
                    WeaponValueView(iconNamed: "affinity", value: weapon.affinity, doColor: true, wrap: { "\($0)%" })
                }
            }

            Spacer()

            VStack(alignment: .leading, spacing: 2) {
                weapon.sharpnesses.map { SharpnessesView(sharpnesses: $0) }
                HStack {
                    SocketsView(weapon: weapon)
                    WeaponValueView(iconNamed: "defense", value: weapon.defense, doColor: true)
                }
            }
        }
    }
}

struct WeaponValueView: View {
    var icon: Icon?
    var text: String
    var color: Color

    init?(iconNamed: String?, value: Int?, isMuted: Bool = false, doColor: Bool = false, wrap: (String) -> String = { return $0 }) {
        self.init(icon: Icon(name: iconNamed), value: value, isMuted: isMuted, doColor: doColor, wrap: wrap)
    }

    init?(icon: Icon?, value: Int?, isMuted: Bool = false, doColor: Bool = false, wrap: (String) -> String = { return $0 }) {
        guard
            let icon = icon,
            let value = value,
            value != 0
            else { return nil }
        self.icon = icon
        text = wrap("\(value)")

        if isMuted {
            color = .secondary
            text = "(\(text))"
        } else if doColor {
            color = value > 0 ? Color(IconColor.green.color) : Color(IconColor.red.color)
        } else {
            color = .primary
        }
    }

    var body: some View {
        HStack(spacing: 0) {
            icon.map { IconImage($0, iconSize: defaultSmallIconSize) }
            Text(text).font(.subheadline).foregroundColor(color)
        }
    }
}
