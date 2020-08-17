//
//  WeaponTypeView.swift
//  MHWDB
//
//  Created by Joe on 8/1/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import SwiftUI

struct WeaponTypeListView: View {

    var body: some View {
        List(WeaponType.allValues, id: \.self) {
            ItemDetailCell(
                icon: $0.displayListIcon,
                titleText: $0.displayName,
                destination: WeaponTreeView(weaponType: $0)
            )
        }
        .navigationBarTitle("Weapon Types")
    }
}
