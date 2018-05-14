//
//  ArmorSetList.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class ArmorSetList: DetailController {
    override func loadView() {
        super.loadView()
        title = "Armor Sets"
        addSimpleSection(data: Database.shared.armorSet()) { ArmorSetDetails($0) }
    }
}

extension ArmorSet: DetailCellModel {
    var primary: String? { return name }
    //var imageName: String? { return nil }
}
