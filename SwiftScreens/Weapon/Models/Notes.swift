//
//  Notes.swift
//  MHGDB
//
//  Created by Joe on 5/8/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation

extension Weapon {
    struct Note {
        let imageName: String
    }

    var noteImageNames: [String]? {
        if let notes = notes {
            return notes.compactMap({ (c: Character) -> String? in
                switch c {
                case "A": return "Note.aqua"
                case "B": return "Note.blue"
                case "G": return "Note.green"
                case "O": return "Note.orange"
                case "P": return "Note.purple"
                case "R": return "Note.red"
                case "W": return "Note.white"
                case "Y": return "Note.yellow"
                default: return nil
                }
            })
        } else {
            return nil
        }
    }
}
