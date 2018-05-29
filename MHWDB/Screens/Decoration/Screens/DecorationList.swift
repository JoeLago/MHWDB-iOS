//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit

class DecorationList: TableController {
    override func loadView() {
        super.loadView()
        title = "Decorations"
        addSimpleSection(data: Database.shared.decorations()) { DecorationDetails(id: $0.id) }
    }
}

extension Decoration: DetailCellModel {
    var primary: String? { return name }
    var subtitle: String? { return skillTree.name }
    var imageName: String? { return icon }
}
