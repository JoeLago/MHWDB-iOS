//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Weapon: Decodable, FetchableRecord, Identifiable {

    var id: Int
    var previousWeaponId: Int?
    var name: String
    var icon: Icon? { return Icon(name: weaponType.imageName, rarity: rarity) }
    var weaponType: WeaponType
    var depths: [Bool]?
    var attack: Int?
    var attackTrue: Int?
    var element1: Element?
    var element1Attack: Int?
    var element2: Element?
    var element2Attack: Int?
    var elementHidden: Bool
    var awakenAttack: Int?
    var elderseal: String?
    var defense: Int?
    var numSlots: Int?
    var creationCost: Int?
    var upgradeCost: Int?
    var sell: Int?
    var affinity: Int?
    var rarity: Int
    var slot1: SocketLevel?
    var slot2: SocketLevel?
    var slot3: SocketLevel?

    var coatingBlast: Bool?
    var coatingClose: Bool?
    var coatingParalysis: Bool?
    var coatingPoison: Bool?
    var coatingPower: Bool?
    var coatingSleep: Bool?

    // specific to weapon type
    var recoil: String?
    var reloadSpeed: String?
    var rapidFire: String?
    var deviation: String?
    var ammoString: String?
    var specialAmmo: String?
    var coatings: String?
    var charges: String?
    var phial: String?
    var phialPower: Int?
    var shelling: String?
    var shellingLevel: Int?
    var kinsectBonus: String?
    var notes: String?
    var sharpness: String?
    var craftable: Bool
    var createRecipeId: Int?
    var upgradeRecipeId: Int?
    var ammoId: Int?

    // Made this optional just to be lazy and not list out all the properties as keys
    var children: [Weapon]? = [Weapon]()

    var sockets: [SocketLevel]? {
        [slot1, slot2, slot3].compactMap({ $0 == SocketLevel.none ? nil : $0 }).nonEmpty
    }

    lazy var sharpnesses: [Sharpness]? = {
        guard let sharpnessValues = sharpness, !sharpnessValues.isEmpty else { return nil }
        return Sharpness.Level.allCases.map { Sharpness(string: sharpnessValues, level: $0) }
    }()

    lazy var skills: [WeaponSkill] = { Database.shared.weaponSkills(weaponId: id) }()
    lazy var createComponents: [RecipeComponent]? = { return createRecipeId.map { Database.shared.recipeComponents(id: $0) } }()
    lazy var upgradeComponents: [RecipeComponent]? = { return upgradeRecipeId.map { Database.shared.recipeComponents(id: $0) } }()
    lazy var melodies: [Melody] = { notes.map({ Database.shared.melodies(weaponNotes: $0) }) ?? [] }()
    lazy var ammo: Ammo? = { ammoId.flatMap({ Database.shared.ammo(ammoId: $0) }) }()

    var coatingIcons: [Coating]? {
        func icon(_ value: Bool?, _ coating: Coating) -> Coating? {
            (value ?? false) ? coating : nil
        }

        return [
            icon(coatingBlast, .blast),
            icon(coatingClose, .close),
            icon(coatingParalysis, .paralysis),
            icon(coatingPoison, .poison),
            icon(coatingPower, .power),
            icon(coatingSleep, .sleep)
        ].compactMap({ $0 }).nonEmpty
    }

    var totalChildren: Int {
        return children?.map({ 1 + $0.totalChildren }).reduce(0, +) ?? 0
    }

    func allChildren() -> [Weapon] {
        guard let children = children else { return [] }
        var allChildren = [Weapon]()
        for child in children {
            allChildren.append(child)
            allChildren += child.allChildren()
        }

        return allChildren
    }
}

extension Weapon {
    static func maxDamage(base: Int?) -> Int {
        return Int(CGFloat(base ?? 0) / 10 * 1.3) * 10
    }
}

enum Coating: String {
    case blast, close, paralysis, poison, power, sleep

    var iconColor: IconColor {
        switch self {
        case .blast: return .green
        case .close: return .white
        case .paralysis: return .yellow
        case .poison: return .darkPurple
        case .power: return .red
        case .sleep: return .cyan
        }
    }

    var icon: Icon { return Icon(name: "items_bottle", color: iconColor) }
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
            let parentId = weapon.previousWeaponId ?? 0
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
        while let parentId = topNode.object.previousWeaponId, parentId > 0 {
            let parentWeapon = weapon(id: parentId)
            let parent = Node(parentWeapon)
            parent.children.append(topNode)
            topNode.parent = parent
            topNode = parent
        }

        let weapons = weaponsByParent(type: baseWeapon.weaponType)
        populateNode(node: weaponNode, weaponsByParent: weapons)

        let tree = Tree<Weapon>()
        tree.roots.append(topNode)
        return (weaponNode, tree)
    }
}

extension Array {
    var nonEmpty: Array? {
        return isEmpty ? nil : self
    }
}
