//
// MIT License
// Copyright (c) Gathering Hall Studios
//


import UIKit

class SearchAllController: UISearchController {
    
    init(mainViewController: UIViewController) {
        let searchListController = SearchAllListController()
        searchListController.mainViewController = mainViewController
        super.init(searchResultsController: searchListController)
        searchResultsUpdater = searchListController
        delegate = searchListController
        searchBar.delegate = searchListController
        dimsBackgroundDuringPresentation = true
        hidesNavigationBarDuringPresentation = true
    }
    
    // DO NOT REMOVE; Why are you calling this Apple?!
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Why Apple?")
    }
}

class SearchAllListController: DetailController  {
    var mainViewController: UIViewController?
    
    override public func push(_ viewController: UIViewController) {
        self.mainViewController?.navigationController?.pushViewController(viewController,
                                                                          animated: true)
    }
    
    public func update(searchText: String?) {
        guard let searchText = searchText else { return }
        
        sections.removeAll()
        
        addSearchSection(data: Database.shared.monsters(searchText), title: "Monsters") { MonsterDetails(id: $0.id) }
        addSearchSection(data: Database.shared.items(searchText), title: "Items") { ItemDetails(item: $0) }
        addSearchSection(data: Database.shared.weapons(searchText), title: "Weapons") { WeaponDetails(id: $0.id) }
        addSearchSection(data: Database.shared.armor(searchText), title: "Armor") { ArmorDetails(id: $0.id) }
        addSearchSection(data: Database.shared.quests(searchText)[0], title: "Quests") { QuestDetails(quest: $0) }
        addSearchSection(data: Database.shared.locations(searchText), title: "Locations") { LocationDetails(location: $0) }
        addSearchSection(data: Database.shared.skillTrees(searchText), title: "Skills") { SkillDetails(id: $0.id) }
        let palicoSection = addCustomSection(
            title: "Palico Weapons", data: Database.shared.palicoWeapons(searchText),
            cellType: PalicoWeaponCell.self) { PalicoWeaponDetails(id: $0.id) }
        palicoSection.defaultCollapseCount = 5
        
        reloadData()
    }
    
    func addSearchSection<T: DetailCellModel>(data: [T], title: String? = nil,
                          selectionBlock: ((T) -> UIViewController)? = nil) {
        add(section: SimpleDetailSection(data: data, title: title, defaultCollapseCount: 5,
                                         selectionBlock: getPushBlock(selectionBlock)))
    }
}

extension Weapon: DetailCellModel {
    var primary: String? { return name }
    var imageName: String? { return icon }
}

extension SearchAllListController: UISearchControllerDelegate {
    
}

extension SearchAllListController: UISearchBarDelegate  {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        update(searchText: searchText)
    }
}

extension SearchAllListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        update(searchText: searchController.searchBar.text)
    }
}
