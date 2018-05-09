//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class WeaponList: DetailController {
    
    init(weaponType: WeaponType) {
        super.init()
        title = weaponType.rawValue
        
        guard let weapons = Database.shared.weaponTree(type: weaponType) else {
            Log(error: "Couldn't find weapons")
            return
        }
        let weaponSection = TreeSection<Weapon, WeaponView>(tree: weapons) {
            self.push(WeaponDetails(id: $0.id))
        }
        add(section: weaponSection)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("I don't want to use storyboards Apple")
    }
}
