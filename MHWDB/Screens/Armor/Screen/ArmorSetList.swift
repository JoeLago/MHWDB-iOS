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
    var customList: CustomSection<ArmorSetCellModel, ArmorSetCell>!
    var segment: UISegmentedControl!

    override func loadView() {
        super.loadView()
        title = "Armor Sets"

        customList = CustomSection(data: [ArmorSetCellModel]()) { [weak self] in
            self?.push(ArmorSetDetails(id: $0.id))
        }

        //add(section: list)
        add(section: customList)

        segment = populateToolbarSegment(items: ["Low", "High"])
        segment.selectedSegmentIndex = 1
        reloadData()
        isToolBarHidden = false
    }

    override func reloadData() {
        let armorSets: [ArmorSet]
        switch segment.selectedSegmentIndex {
        case 0: armorSets = Database.shared.armorSet(rank: .low)
        case 1: armorSets = Database.shared.armorSet(rank: .high)
        case 2: armorSets = Database.shared.armorSet(hrArmorType: 0)
        case 3: armorSets = Database.shared.armorSet(hrArmorType: 1)
        default: return
        }

        //list.rows = armorSets
        customList.rows = armorSets.map { ArmorSetCellModel(set: $0) }

        tableView.reloadData()
    }
}

extension ArmorSetCellModel {
    init(set: ArmorSet) {
        id = set.id
        label = set.name
        svgModels = set.armor.compactMap { $0.svgModel }
    }
}

extension ArmorSet: DetailCellModel {
    var primary: String? { return name }
    //var imageName: String? { return nil }
}
