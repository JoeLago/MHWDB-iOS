//
//  MonsterBreak.swift
//  MHWDB
//
//  Created by Joe on 9/14/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB
import UIKit

struct MonsterBreak: FetchableRecord, Decodable {
    let id: Int
    let partName: String
    let flinch: Int?
    let wound: Int?
    let sever: Int?
    let extract: String?

    var values: [String] {
        [flinch, wound, sever].map({ value in value.map { "\($0)" } ?? "-" })
            + [extract?.capitalized ?? ""]
    }
}

extension Database {
    func monsterBreaks(monsterId: Int) -> [MonsterBreak] {
        let query = Query(table: "monster_break")
            .join(table: "monster_break_text")
            .filter("monster_id", equals: monsterId)
        return fetch(query)
    }
}
