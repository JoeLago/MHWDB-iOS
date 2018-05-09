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
                case "A": return "Note.aqua.png"
                case "B": return "Note.blue.png"
                case "G": return "Note.green.png"
                case "O": return "Note.orange.png"
                case "P": return "Note.purple.png"
                case "R": return "Note.red.png"
                case "W": return "Note.white.png"
                case "Y": return "Note.yellow.png"
                default: return nil
                }
            })
        } else {
            return nil
        }
    }
}
