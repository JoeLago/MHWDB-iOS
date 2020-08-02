//
//  SkillTreeSkills.swift
//  MHWDB
//
//  Created by Joe on 5/28/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class SkillTreeSkill: FetchableRecord, Decodable, Identifiable {
    let description: String
    let icon: String?
    let level: Int
    var id: Int { return level }
}

extension Database {
    func skillTreeSkills(skillTreeId: Int) -> [SkillTreeSkill] {
        let query = Query(table: "skill")
            .filter("skilltree_id", equals: skillTreeId)
        return fetch(query)
    }
}
