//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class DecorationDetails: TableController, DetailScreen {
    var id: Int

    convenience init(id: Int) {
        self.init(Database.shared.decoration(id: id))
    }

    init(_ decoration: Decoration) {
        id = decoration.id
        super.init()
        title = decoration.name
        addSimpleSection(data: [decoration])
        add(section: DecorationDetailSection(decoration: decoration))
        addSimpleSection(data: [decoration.skillTree])
        add(section: DecorationDropSection(decoration: decoration))
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
