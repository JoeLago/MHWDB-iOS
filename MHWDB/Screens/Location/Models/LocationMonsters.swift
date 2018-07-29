//
//  LocationMonsters.swift
//  MHWDB
//
//  Created by Joe on 5/26/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class LocationMonster: FetchableRecord, Decodable {
    let monsterId: Int
    var name: String?
    let icon: String?
    var startArea: String?
    var moveArea: String
    var restArea: String?

    var areas: String {
        return [startArea, moveArea, restArea].compactMap { $0 }.joined(separator: " > ")
    }

    enum CodingKeys: String, CodingKey {
        case monsterId = "monster_id", name, icon, startArea = "start_area", moveArea = "move_area", restArea = "rest_area"
    }
}

extension Database {
    func locationMonsters(locationId: Int) -> [LocationMonster] {
        let query = Query(table: "monster_habitat")
            .join(table: "monster_text", on: "monster_id")
            .filter("location_id", equals: locationId)
        return fetch(query)
    }
}
