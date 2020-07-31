//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import UIKit
import SwiftUI

class ListMenu: SimpleTableViewController {
    var searchController: SearchAllController!

    override func loadView() {
        super.loadView()
        title = "MHWDB"

        definesPresentationContext = true
        searchController = SearchAllController(mainViewController: self)

        if #available(iOS 11, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }

        //addCell(text: "Quests", imageName: "Quest-Icon-Red.png") { QuestList() }
        addCell(text: "Monsters Swift", imageName: "great-jagras.png") { UIHostingController(rootView: MonsterListView()) }
        addCell(text: "Monsters", imageName: "great-jagras.png") { MonsterList() }
        addCell(text: "Weapons", imageName: "great_sword8.png") { WeaponTypeList() }
        addCell(text: "Armor", imageName: "body4.png") { ArmorSetList() }
        addCell(text: "Items", imageName: "Ore-Purple.png") { ItemList() }
        addCell(text: "Combinations", imageName: "Liquid-Green.png") { CombinationList() }
        addCell(text: "Locations", imageName: "Map-Icon-White.png") { LocationList() }
        addCell(text: "Charms", imageName: "Quest-Icon-White.png") { CharmList() }
        addCell(text: "Decorations", imageName: "Jewel-Cyan.png") { DecorationList() }
        addCell(text: "Skills", imageName: "Monster-Jewel-Teal.png") { SkillList() }
        //addCell(text: "Palico", imageName: "cutting3.png") { PalicoList() }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if #available(iOS 10.3, *) {
            ReviewManager.presentReviewControllerIfElligible()
        }
    }
}
