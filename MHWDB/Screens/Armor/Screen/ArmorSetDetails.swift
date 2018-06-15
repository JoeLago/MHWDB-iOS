//
//  ArmorSetDetails.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class ArmorSetDetails: TableController, DetailScreen {
    var id: Int

    convenience init(id: Int) {
        self.init(Database.shared.armorSet(id: id))
    }

    init(_ armorSet: ArmorSet) {
        id = armorSet.id
        super.init()
        title = armorSet.name
        addSimpleSection(data: armorSet.armor, title: "Armor") { ArmorDetails(id: $0.id) }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Armor: DetailCellModel {
    var primary: String? { return name }
    //var subtitle: String? { return slotsString }
    var subtitle: String? { return "\(defense) - \(defenseMax) def" }
    var imageName: String? { return icon }
    var svgModel: SVGImageModel? { return svg }
}
