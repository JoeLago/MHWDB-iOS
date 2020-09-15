//
//  WeaponTreeView.swift
//  MHWDB
//
//  Created by Joe on 8/1/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct WeaponTreeView: View {
    var weaponType: WeaponType
    var weapons: Tree<Weapon>?

    init(weaponType: WeaponType) {
        self.weaponType = weaponType
        weapons = Database.shared.weaponTree(type: weaponType)
    }

    var body: some View {
        List {
            weapons.map { weapons in
                TreeSectionView(tree: weapons) { weapon in
                    NavigationLink(destination: NavigationLazyView({ WeaponDetailView(id: weapon.id) })) {
                        WeaponCellView(weapon: weapon)
                    }
                }
            }
        }
        .navigationBarTitle(weaponType.displayName)
    }
}
