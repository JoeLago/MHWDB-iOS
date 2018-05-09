//
//  WeaponAmmo.swift
//  MHGDB
//
//  Created by Joe on 5/8/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation

class Ammo {
    let normal1: AmmoType
    let normal2: AmmoType
    let normal3: AmmoType
    let pierce1: AmmoType
    let pierce2: AmmoType
    let pierce3: AmmoType
    let pellet1: AmmoType
    let pellet2: AmmoType
    let pellet3: AmmoType
    let crag1: AmmoType
    let crag2: AmmoType
    let crag3: AmmoType
    let clust1: AmmoType
    let clust2: AmmoType
    let clust3: AmmoType
    let poison1: AmmoType
    let poison2: AmmoType
    let paralysis1: AmmoType
    let paralysis2: AmmoType
    let sleep1: AmmoType
    let sleep2: AmmoType
    let exhaust1: AmmoType
    let exhaust2: AmmoType
    let fire: AmmoType
    let water: AmmoType
    let thunder: AmmoType
    let ice: AmmoType
    let dragon: AmmoType
    
    init(string: String) {
        let values = string.components(separatedBy: "|")
        
        normal1 = AmmoType(values, 0)
        normal2 = AmmoType(values, 1)
        normal3 = AmmoType(values, 2)
        pierce1 = AmmoType(values, 3)
        pierce2 = AmmoType(values, 4)
        pierce3 = AmmoType(values, 5)
        pellet1 = AmmoType(values, 6)
        pellet2 = AmmoType(values, 7)
        pellet3 = AmmoType(values, 8)
        crag1 = AmmoType(values, 9)
        crag2 = AmmoType(values, 10)
        crag3 = AmmoType(values, 11)
        clust1 = AmmoType(values, 12)
        clust2 = AmmoType(values, 13)
        clust3 = AmmoType(values, 14)
        
        fire = AmmoType(values, 15)
        water = AmmoType(values, 16)
        thunder = AmmoType(values, 17)
        ice = AmmoType(values, 18)
        dragon = AmmoType(values, 19)
        
        poison1 = AmmoType(values, 20)
        poison2 = AmmoType(values, 21)
        paralysis1 = AmmoType(values, 22)
        paralysis2 = AmmoType(values, 23)
        sleep1 = AmmoType(values, 24)
        sleep2 = AmmoType(values, 25)
        exhaust1 = AmmoType(values, 26)
        exhaust2 = AmmoType(values, 27)
    }
}

class AmmoType: StyledText {
    // TODO: text should be int value and isbold should be named whatever that represents
    // text and isBold should be in separate extension
    // (in AmmoCell.swift since it's a UI thing)
    // and return these new values to conform to protocol
    
    let text: String
    let isBold: Bool
    
    init(text: String, isBold: Bool = false) {
        self.text = text
        self.isBold = isBold
    }
    
    convenience init(_ values: [String], _ index: Int) {
        let stringValue = values[index]
        if let index = stringValue.range(of: "*") {
            self.init(text: String(stringValue[..<index.lowerBound]), isBold: true)
        }
        else {
            self.init(text: stringValue)
        }
    }
}
