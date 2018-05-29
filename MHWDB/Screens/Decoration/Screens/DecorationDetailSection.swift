//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class DecorationDetailSection: MultiCellSection {
    var decoration: Decoration

    init(decoration: Decoration) {
        self.decoration = decoration
        super.init()
        title = "Details"
    }

    override func populateCells() {
        addCell(SingleDetailCell(label: "Slot Size", text: "\(decoration.slotSize)"))
    }
}
