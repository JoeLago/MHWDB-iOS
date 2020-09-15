//
//  LocationCamp.swift
//  MHWDB
//
//  Created by Joe on 8/21/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

class LocationCamp: FetchableRecord, Identifiable, Decodable {
    var id: Int
    var name: String
    var area: Int

    var icon: Icon { return Icon(name: "camp") }
}

extension Database {
    func locationCamps(locationId: Int) -> [LocationCamp] {
        let query = Query(table: "location_camp_text", addLanguageFilter: true)
            .filter("location_id", equals: locationId)
        return fetch(query)
    }
}
