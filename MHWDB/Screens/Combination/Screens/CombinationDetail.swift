//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class CombinationDetails: TableController, DetailScreen {
    var id: Int

    convenience init(id: Int) {
        self.init(Database.shared.combination(id: id))
    }

    init(_ combination: Combination) {
        id = combination.id
        super.init()
        title = combination.resultName
        addSimpleSection(data: [combination.created], title: "Created") { ItemDetails(id: $0.id) }
        addSimpleSection(data: [combination.first, combination.second], title: "Components") { ItemDetails(id: $0.id) }
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
