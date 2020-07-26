//
//  LocationMonsters.swift
//  MHWDB
//
//  Created by Joe on 5/26/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class LocationMonster: FetchableRecord, Decodable, Identifiable {
    var id: Int { return monsterId }
    let monsterId: Int
    var name: String?
    var icon: String? { return size == .large ? "\(monsterId)" : nil }
    var size: Monster.Size?
    var startArea: String?
    var moveArea: String
    var restArea: String?

    var areas: String {
        return [startArea, moveArea, restArea].compactMap { $0 }.joined(separator: " > ")
    }
}

extension Database {
    func locationMonsters(locationId: Int) -> [LocationMonster] {
        let query = Query(table: "monster_habitat")
            .join(table: "monster", on: "monster_id")
            .join(table: "monster_text", on: "monster_id")
            .filter("location_id", equals: locationId)
        return fetch(query)
    }
}
