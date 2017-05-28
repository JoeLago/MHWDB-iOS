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
    var searchText: String? = nil
    var deferredSearch: String? = nil
    var isSearching = false
    
    override public func push(_ viewController: UIViewController) {
        self.mainViewController?.navigationController?.pushViewController(viewController,
                                                                          animated: true)
    }
    
    public func update(searchText: String?) {
        guard let searchText = searchText else { return }
        
        if isSearching {
            deferredSearch = searchText
            return
        }
        
        isSearching = true
        
        DispatchQueue.global(qos: .background).async {
            
            let monsters = Database.shared.monsters(searchText)
            let items = Database.shared.items(searchText)
            let weapons = Database.shared.weapons(searchText)
            let armor = Database.shared.armor(searchText)
            let quests = Database.shared.quests(searchText)[0]
            let locations = Database.shared.locations(searchText)
            let skills = Database.shared.skillTrees(searchText)
            let palico = Database.shared.palicoWeapons(searchText)
            
            DispatchQueue.main.async {
                self.searchText = searchText
                self.sections.removeAll()
                
                self.addSearchSection(data: monsters, title: "Monsters") { MonsterDetails(id: $0.id) }
                self.addSearchSection(data: items, title: "Items") { ItemDetails(item: $0) }
                self.addSearchSection(data: weapons, title: "Weapons") { WeaponDetails(id: $0.id) }
                self.addSearchSection(data: armor, title: "Armor") { ArmorDetails(id: $0.id) }
                self.addSearchSection(data: quests, title: "Quests") { QuestDetails(quest: $0) }
                self.addSearchSection(data: locations, title: "Locations") { LocationDetails(location: $0) }
                self.addSearchSection(data: skills, title: "Skills") { SkillDetails(id: $0.id) }
                let palicoSection = self.addCustomSection(title: "Palico Weapons", data: palico, cellType: PalicoWeaponCell.self)
                { PalicoWeaponDetails(id: $0.id) }
                palicoSection.defaultCollapseCount = 5
                
                self.reloadData()
                
                self.isSearching = false
                if self.deferredSearch != nil {
                    self.update(searchText: self.deferredSearch)
                    self.deferredSearch = nil
                }
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Log(search: searchText ?? "no text")
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
