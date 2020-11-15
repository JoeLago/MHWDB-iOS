//
//  Language.swift
//  MHWDB
//
//  Created by Joe on 9/26/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import GRDB

struct Language: Decodable, FetchableRecord, Identifiable {
    var id: String
    var language: String
    var isComplete: Bool
}

extension Database {
    func languages() -> [Language] {
        let query = Query(table: "languages")
        return fetch(query)
    }
}
