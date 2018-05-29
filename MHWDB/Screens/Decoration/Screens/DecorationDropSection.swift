//
//  DecorationDropSection.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class DecorationDropSection: MultiCellSection {
    var decoration: Decoration

    init(decoration: Decoration) {
        self.decoration = decoration
        super.init()
        title = "Feystone Drop Rates"
    }

    override func populateCells() {
        addCell(MultiDetailCell(details: [
            SingleDetailLabel(label: "Warped", value: "\(decoration.warpedFeystoneChance)%"),
            SingleDetailLabel(label: "Worn", value: "\(decoration.wornFeystoneChance)%"),
            SingleDetailLabel(label: "Glowing", value: "\(decoration.glowingFeystoneChance)%"),
            SingleDetailLabel(label: "Mysterious", value: "\(decoration.mysteriousFeystoneChance)%")
            ]))
    }
}
