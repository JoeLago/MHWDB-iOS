//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class WeaponTypeList: SimpleTableViewController {
    override func loadView() {
        super.loadView()

        for weaponType in WeaponType.allValues {
            addWeapon(weaponType: weaponType)
        }
    }

    func addWeapon(weaponType: WeaponType) {
        addCell(text: weaponType.rawValue, imageName: weaponType.imageName, selectedBlock: { () in
            self.push(viewController: WeaponList(weaponType: weaponType))
        })
    }
}
