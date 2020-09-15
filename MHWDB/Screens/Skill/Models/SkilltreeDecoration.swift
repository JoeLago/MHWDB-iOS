//
//  SkilltreeDecorations.swift
//  MHWDB
//
//  Created by Joe on 8/21/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

extension Database {
    func skillDecorations(skilltreeId: Int) -> [Decoration] {
        let query = Query(table: "decoration")
            .join(table: "decoration_text", addLanguageFilter: true)
            .filter("skilltree_id", equals: skilltreeId)
            .order(by: "skilltree_level", direction: .dec)
        return fetch(query)
    }
}
