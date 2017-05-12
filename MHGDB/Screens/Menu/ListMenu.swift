//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class ListMenu: SimpleTableViewController {
    var searchController: SearchAllController!
    
    override func loadView() {
        super.loadView()
        title = "MHGDB"
        
        searchController = SearchAllController(mainViewController: self)
        
        addCell(text: "Quests", imageName: "Quest-Icon-Red.png") { QuestList() }
        addCell(text: "Monsters", imageName: "Rathalos.png") { MonsterList() }
        addCell(text: "Weapons", imageName: "great_sword8.png") { WeaponTypeList() }
        addCell(text: "Armor", imageName: "body4.png") { ArmorList() }
        addCell(text: "Items", imageName: "Ore-Purple.png") { ItemList() }
        addCell(text: "Combinations", imageName: "Liquid-Green.png") { CombinationList() }
        addCell(text: "Locations", imageName: "Map-Icon-White.png") { LocationList() }
        addCell(text: "Decorations", imageName: "Jewel-Cyan.png") { DecorationList() }
        addCell(text: "Skills", imageName: "Monster-Jewel-Teal.png") { SkillList() }
        addCell(text: "Palico", imageName: "cutting3.png") { PalicoList() }
        
        tableView.tableHeaderView = searchController.searchBar
        definesPresentationContext = true
    }
}
