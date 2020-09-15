//
//  SocketLevel.swift
//  MHWDB
//
//  Created by Joe on 9/6/20.
//  Copyright © 2020 Gathering Hall Studios. All rights reserved.
//

import Foundation

enum SocketLevel: Int, Decodable {
    case none, one, two, three, four

    var iconName: String? {
        switch self {
        case .none: return "slot_none"
        case .one: return "slot_1_empty"
        case .two: return "slot_2_empty"
        case .three: return "slot_3_empty"
        case .four: return "slot_4_empty"
        }
    }
}
