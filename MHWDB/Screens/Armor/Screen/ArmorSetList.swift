//
//  ArmorSetList.swift
//  MHWDB
//
//  Created by Joe on 5/13/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

// TODO: Should show more stats in these cells

import UIKit

class ArmorSetList: TableController {
    var list: SimpleDetailSection<ArmorSet>!
    var segment: UISegmentedControl!

    override func loadView() {
        super.loadView()
        title = "Armor Sets"

        list = SimpleDetailSection(data: [ArmorSet]()) { [weak self] in
            self?.push(ArmorSetDetails($0))
        }
        add(section: list)

        segment = populateToolbarSegment(items: ["Low", "High", "Alpha", "Beta"])
        segment.selectedSegmentIndex = 1
        reloadData()
        isToolBarHidden = false
    }

    override func reloadData() {
        switch segment.selectedSegmentIndex {
        case 0: list.rows = Database.shared.armorSet(rank: .low)
        case 1: list.rows = Database.shared.armorSet(rank: .high)
        case 2: list.rows = Database.shared.armorSet(hrArmorType: 0)
        case 3: list.rows = Database.shared.armorSet(hrArmorType: 1)
        default: return
        }
        tableView.reloadData()
    }
}

extension ArmorSet: DetailCellModel {
    var primary: String? { return name }
    //var imageName: String? { return nil }
}
