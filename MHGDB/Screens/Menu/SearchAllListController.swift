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
    var searchRequest: SearchRequest? = nil
    
    override public func push(_ viewController: UIViewController) {
        Log(search: searchText ?? "No Text")
        self.mainViewController?.navigationController?.pushViewController(viewController,
                                                                          animated: true)
    }
    
    public func update(searchText: String?) {
        guard let searchText = searchText, searchText.characters.count > 0 else { return }
        
        if let searchRequest = searchRequest {
            deferredSearch = searchText
            searchRequest.cancel()
            return
        }
        
        self.sections.removeAll()
        self.reloadData()
        
        searchRequest = SearchRequest(searchText)
            .then { [unowned self] in
                self.searchText = searchText
                self.searchRequest = nil
                //Log(searchText) // Verbose debugging
                self.updateTable(response: $0)
            }
            .canceled { [unowned self] in
                self.searchRequest = nil
                self.update(searchText: self.deferredSearch)
                self.deferredSearch = nil
        }
    }
    
    func updateTable(response: SearchResponse) {
        addSearchSection(data: response.monsters, title: "Monsters") { MonsterDetails(id: $0.id) }
        addSearchSection(data: response.items, title: "Items") { ItemDetails(item: $0) }
        addSearchSection(data: response.weapons, title: "Weapons") { WeaponDetails(id: $0.id) }
        addSearchSection(data: response.armor, title: "Armor") { ArmorDetails(id: $0.id) }
        addSearchSection(data: response.quests, title: "Quests") { QuestDetails(quest: $0) }
        addSearchSection(data: response.locations, title: "Locations") { LocationDetails(location: $0) }
        addSearchSection(data: response.skills, title: "Skills") { SkillDetails(id: $0.id) }
        let palicoSection = addCustomSection(title: "Palico Weapons", data: response.palico, cellType: PalicoWeaponCell.self)
        { PalicoWeaponDetails(id: $0.id) }
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

extension SearchAllListController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        update(searchText: searchController.searchBar.text)
    }
}
