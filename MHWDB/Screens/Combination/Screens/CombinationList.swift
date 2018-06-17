//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class CombinationList: TableController {
    override func loadView() {
        super.loadView()
        title = "Combinations"
        addCustomSection(data: Database.shared.combinations().map {
            CombinationCellModel(combination: $0, itemSelected: { self.push(ItemDetails(id: $0)) }) },
                         cellType: CombinationCell.self)
    }
}
