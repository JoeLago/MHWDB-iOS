//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Weapon: Decodable, RowConvertible {

    var id: Int
    var parentId: Int?
    var name: String
    var icon: String? {
        return "\(type.imagePrefix)\(rarity).png"
    }
    var type: WeaponType
    var depths: [Bool]?
    var children = [Weapon]()
    var attack: Int?
    var element: Element?
    var elementAttack: Int?
    var awakenElement: Element?
    var awakenAttack: Int?
    var defense: Int?
    //var sharpnesses: [Sharpness]?
    var numSlots: Int?
    var creationCost: Int?
    var upgradeCost: Int?
    var sell: Int?
    var affinity: Int?
    var rarity: Int
    var slotOne: Bool?
    var slotTwo: Bool?
    var slotThree: Bool?

    // specific to weapon type
    var recoil: String?
    var reloadSpeed: String?
    var rapidFire: String?
    var deviation: String?
    var ammoString: String?
    //var ammo: Ammo?
    var specialAmmo: String?
    var coatings: String?
    var charges: String?
    var phial: String?
    var phialAttack: Int?
    var shellingType: String?
    var notes: String?

    enum CodingKeys: String, CodingKey {
        case id, parentId = "previous_weapon_id", name, type = "weapon_type", depths, attack, element = "element_type", elementAttack = "element_damage", awakenElement, awakenAttack, defense, numSlots, creationCost, upgradeCost, sell, affinity, rarity, slotOne = "slot_1", slotTwo = "slot_2", slotThree = "slot_3", recoil, reloadSpeed, rapidFire, deviation, ammoString, specialAmmo, coatings, charges, phial, phialAttack, shellingType, notes
    }

    var components: [WeaponComponent] {
        return Database.shared.components(weaponId: id)
    }

    var coatingImageNames: [String]? {
        if let coatings = Int(coatings) {
            var coatingImageNames = [String]()

            if (coatings & 0x0400) > 0 || (coatings & 0x0200) > 0 { coatingImageNames.append("Bottle-Red.png") }
            if (coatings & 0x20) > 0 { coatingImageNames.append("Bottle-Purple.png") }
            if (coatings & 0x10) > 0 { coatingImageNames.append("Bottle-Yellow.png") }
            if (coatings & 0x08) > 0 { coatingImageNames.append("Bottle-Cyan.png") }
            if (coatings & 0x40) > 0 { coatingImageNames.append("Bottle-White.png") }
            if (coatings & 0x04) > 0 { coatingImageNames.append("Bottle-Blue.png") }
            if (coatings & 0x02) > 0 { coatingImageNames.append("Bottle-Orange.png") }

            return coatingImageNames
        } else {
            return nil
        }
    }

    var numChildren: Int {
        var count = 0
        for weapon in children {
            count += 1
            count += weapon.numChildren
        }

        return count
    }

    func allChildren() -> [Weapon] {
        var allChildren = [Weapon]()
        for child in children {
            allChildren.append(child)
            allChildren += child.allChildren()
        }

        return allChildren
    }
}

extension Weapon: CustomDebugStringConvertible {
    var debugDescription: String {
        return name
    }
}

extension Weapon: CustomStringConvertible {
    var description: String {
        return name
    }
}

extension Database {

    func weapon(id: Int) -> Weapon {
        let query = Query(table: "weapon")
            .join(table: "weapon_text")
            .filter(id: id)
        return fetch(query)[0]
    }

    func allWeapons() -> [Weapon] {
        let query = Query(table: "weapon")
            .join(table: "weapon_text")
        return fetch(query)
    }

    func weapons(_ search: String) -> [Weapon] {
        let query = Query(table: "weapon")
            .join(table: "weapon_text")
            .filter("name", contains: search)
        return fetch(query)
    }

    func weaponQuery(type: WeaponType) -> Query {
        return Query(table: "weapon")
            .join(table: "weapon_text")
            .filter("weapon_type", equals: type.rawValue)
    }

    func weaponsByParent(type: WeaponType) -> [Int: [Weapon]] {
        var weaponsByParent = [Int: [Weapon]]()

        let query = weaponQuery(type: type)
        let weapons = fetch(query) as [Weapon]
        for weapon in weapons {
            let parentId = weapon.parentId ?? 0
            var children = weaponsByParent[parentId] ?? [Weapon]()
            children.append(weapon)
            weaponsByParent[parentId] = children
        }

        return weaponsByParent
    }

    func weaponTree(type: WeaponType) -> Tree<Weapon>? {
        let weaponParentTable = weaponsByParent(type: type)
        guard let parent = weaponParentTable[0] else {
            Log(error: "Weapon tree root missing")
            return nil
        }
        let tree = Tree<Weapon>(objects: parent)
        for node in tree.roots {
            populateNode(node: node, weaponsByParent: weaponParentTable)
        }
        return tree
    }

    func populateNode(node: Node<Weapon>, weaponsByParent: [Int: [Weapon]]) {
        guard let weapons = weaponsByParent[node.object.id] else {
            return
        }
        node.addChildren(weapons)

        for node in node.children {
            populateNode(node: node, weaponsByParent: weaponsByParent)
        }
    }

    func weaponTree(weaponId: Int) -> (Node<Weapon>, Tree<Weapon>) {
        let baseWeapon = weapon(id: weaponId)

        let weaponNode = Node(baseWeapon)
        var topNode = weaponNode
        while let parentId = topNode.object.parentId, parentId > 0 {
            let parentWeapon = weapon(id: parentId)
            let parent = Node(parentWeapon)
            parent.children.append(topNode)
            topNode.parent = parent
            topNode = parent
        }

        let weapons = weaponsByParent(type: baseWeapon.type)
        populateNode(node: weaponNode, weaponsByParent: weapons)

        let tree = Tree<Weapon>()
        tree.roots.append(topNode)
        return (weaponNode, tree)
    }
}
