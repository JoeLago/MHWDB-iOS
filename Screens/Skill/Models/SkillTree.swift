//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Skilltree: FetchableRecord, Decodable, Identifiable {
    var id: Int
    var iconColor: IconColor?
    var name: String
    var description: String?

    var icon: Icon { return Icon(name: "armor_skill", color: iconColor) }

    lazy var skills: [SkilltreeSkill] = { return Database.shared.skilltreeSkills(skilltreeId: self.id) }()
    lazy var charms: [SkilltreeCharm] = { return Database.shared.skillCharms(skilltreeId: self.id) }()
    lazy var decorations: [Decoration] = { return Database.shared.skillDecorations(skilltreeId: self.id) }()
    func armor(slot: Armor.Slot) -> [SkilltreeArmor] { return Database.shared.skillArmor(skilltreeId: self.id, slot: slot) }
}

extension Database {
    func skilltree(id: Int) -> Skilltree {
        let query = Query(table: "skilltree").join(table: "skilltree_text").filter(id: id)
        return fetch(query)[0]
    }

    func skilltrees(_ search: String? = nil) -> [Skilltree] {
        let query = Query(table: "skilltree").join(table: "skilltree_text").order(by: "name")
        if let search = search { query.filter("name", contains: search) }
        return fetch(query)
    }
}
