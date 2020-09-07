//
//  ArmorSlotsView.swift
//  MHWDB
//
//  Created by Joe on 9/6/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct SocketsView: View {
    @State var sockets: [SocketLevel]

    init(armor: Armor) {
        let sockets = [armor.slot1, armor.slot2, armor.slot3]
        _sockets = .init(initialValue: sockets)
    }

    init(weapon: Weapon) {
        let sockets = [weapon.slot1, weapon.slot2, weapon.slot3].compactMap { $0 == SocketLevel.none ? nil : $0 }
        _sockets = .init(initialValue: sockets)
    }

    var body: some View {
        HStack(spacing: 2) {
            ForEach(Array(sockets.enumerated()), id: \.offset) {
                IconImage(Icon(name: $0.element.iconName), iconSize: defaultSmallIconSize)
            }
        }
    }
}
