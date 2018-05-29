//
//  CharmDetails.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import UIKit

class CharmDetails: TableController, DetailScreen {
    var id: Int

    convenience required init(id: Int) {
        self.init(charm: Database.shared.charm(id: id))
    }

    init(charm: Charm) {
        id = charm.id
        super.init()
        title = charm.name
        sections = [
            SimpleDetailSection(data: [charm]),
            SimpleDetailSection(data: charm.skills, title: "Skills"), //{ MonsterDetails(id: $0.monsterId) }
            SimpleDetailSection(title: "Recipe", data: charm.items) { ItemDetails(id: $0.id) }
        ]
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("I don't want to use storyboards Apple")
    }
}

extension CharmSkill: DetailCellModel {
    var primary: String? { return name }
    var imageName: String? { return icon }
    var subtitle: String? { return description }
    var secondary: String? { return "\(level)" }
}

extension CharmItem: DetailCellModel {
    var primary: String? { return name }
    var imageName: String? { return icon }
    var secondary: String? { return "x \(quantity)" }
}
