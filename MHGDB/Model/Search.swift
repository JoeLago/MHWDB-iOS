//
//  Search.swift
//  MHGDB
//
//  Created by Joe on 5/28/17.
//  Copyright © 2017 Gathering Hall Studios. All rights reserved.
//

import Foundation

struct SearchResponse {
    let monsters: [Monster]
    let items: [Item]
    let weapons: [Weapon]
    let armor: [Armor]
    let quests: [Quest]
    let locations: [Location]
    let skills: [SkillTree]
    let palico: [PalicoWeapon]
}

class SearchRequest {
    let searchText: String
    var isCanceled = false
    var cancelBlock: ((Void) -> Void)?
    
    init(_ text: String) {
        self.searchText = text
    }
    
    func cancel() {
        isCanceled = true
        DispatchQueue.main.async {
            self.cancelBlock?()
        }
    }
    
    @discardableResult
    func then(_ completed: @escaping (SearchResponse) -> Void) -> SearchRequest {
        DispatchQueue.global(qos: .background).async {
            let searchText = self.searchText
            let monsters = Database.shared.monsters(searchText)
            if self.isCanceled { return }
            let items = Database.shared.items(searchText)
            if self.isCanceled { return }
            let weapons = Database.shared.weapons(searchText)
            if self.isCanceled { return }
            let armor = Database.shared.armor(searchText)
            if self.isCanceled { return }
            let quests = Database.shared.quests(searchText)[0] // Only returning Village
            if self.isCanceled { return }
            let locations = Database.shared.locations(searchText)
            if self.isCanceled { return }
            let skills = Database.shared.skillTrees(searchText)
            if self.isCanceled { return }
            let palico = Database.shared.palicoWeapons(searchText)
            if self.isCanceled { return }
            
            DispatchQueue.main.async {
                completed(SearchResponse(
                    monsters: monsters,
                    items: items,
                    weapons: weapons,
                    armor: armor,
                    quests: quests,
                    locations: locations,
                    skills: skills,
                    palico: palico))
            }
        }
        
        return self
    }
    
    @discardableResult
    func canceled(_ cancelBlock: @escaping (Void) -> Void) -> SearchRequest {
        self.cancelBlock = cancelBlock
        return self
    }
}
