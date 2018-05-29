//
//  CharmList.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class CharmList: TableController {
    override func loadView() {
        super.loadView()
        title = "Charms"
        addSimpleSection(data: Database.shared.charms()) { CharmDetails(id: $0.id) }
    }
}

extension Charm: DetailCellModel {
    var primary: String? { return name }
    var imageName: String? { return icon }
}
