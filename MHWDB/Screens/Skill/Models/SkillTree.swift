//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class SkillTree: FetchableRecord, Decodable {
    var id: Int
    var color: IconColor?
    var name: String
    var description: String

    enum CodingKeys: String, CodingKey {
        case id, color = "icon_color", name, description
    }

    var svgIcon: SVGImageModel? {
        let iconColor = (color ?? .white).color
        return SVGImageModel(name: "armor-skill.svg", color: iconColor)
    }

    lazy var skills: [SkillTreeSkill] = { return Database.shared.skillTreeSkills(skillTreeId: self.id) }()
    lazy var charms: [SkillTreeItem] = { return Database.shared.skillCharms(skillTreeId: self.id) }()
    func armor(slot: Armor.Slot) -> [SkillTreeItem] { return Database.shared.skillArmor(skillTreeId: self.id, slot: slot) }
}

extension Database {
    func skillTree(id: Int) -> SkillTree {
        let query = Query(table: "skilltree").join(table: "skilltree_text").filter(id: id)
        return fetch(query)[0]
    }

    func skillTrees(_ search: String? = nil) -> [SkillTree] {
        let query = Query(table: "skilltree").join(table: "skilltree_text").order(by: "name")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
