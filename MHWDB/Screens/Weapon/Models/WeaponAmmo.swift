//
//  WeaponAmmo.swift
//  MHGDB
//
//  Created by Joe on 5/8/18.
//  Copyright © 2018 Gathering Hall Studios. All rights reserved.
//

import Foundation
import GRDB

// Ooooooooooooooooooooooooooof
struct Ammo: Decodable, FetchableRecord, Identifiable {
    let id: Int
    let deviation: String
    let specialAmmo: String

    let cluster1Clip: Int?
    let cluster1Rapid: Bool?
    let cluster1Recoil: Int?
    let cluster1Reload: String?

    let cluster2Clip: Int?
    let cluster2Rapid: Bool?
    let cluster2Recoil: Int?
    let cluster2Reload: String?

    let cluster3Clip: Int?
    let cluster3Rapid: Bool?
    let cluster3Recoil: Int?
    let cluster3Reload: String?

    let dragonClip: Int
    let dragonRapid: Bool
    let dragonRecoil: Int
    let dragonReload: String?

    let exhaust1Clip: Int
    let exhaust1Rapid: Bool
    let exhaust1Recoil: Int
    let exhaust1Reload: String?

    let exhaust2Clip: Int
    let exhaust2Rapid: Bool
    let exhaust2Recoil: Int
    let exhaust2Reload: String?

    let flamingClip: Int
    let flamingRapid: Bool
    let flamingRecoil: Int
    let flamingReload: String?

    let freezeClip: Int
    let freezeRapid: Bool
    let freezeRecoil: Int
    let freezeReload: String?

    let normal1Clip: Int
    let normal1Rapid: Bool
    let normal1Recoil: Int
    let normal1Reload: String?

    let normal2Clip: Int
    let normal2Rapid: Bool
    let normal2Recoil: Int
    let normal2Reload: String?

    let normal3Clip: Int
    let normal3Rapid: Bool
    let normal3Recoil: Int
    let normal3Reload: String?

    let paralysis1Clip: Int
    let paralysis1Rapid: Bool
    let paralysis1Recoil: Int
    let paralysis1Reload: String?

    let paralysis2Clip: Int
    let paralysis2Rapid: Bool
    let paralysis2Recoil: Int
    let paralysis2Reload: String?

    let pierce1Clip: Int
    let pierce1Rapid: Bool
    let pierce1Recoil: Int
    let pierce1Reload: String?

    let pierce2Clip: Int
    let pierce2Rapid: Bool
    let pierce2Recoil: Int
    let pierce2Reload: String?

    let pierce3Clip: Int
    let pierce3Rapid: Bool
    let pierce3Recoil: Int
    let pierce3Reload: String?

    let poison1Clip: Int
    let poison1Rapid: Bool
    let poison1Recoil: Int
    let poison1Reload: String?

    let poison2Clip: Int
    let poison2Rapid: Bool
    let poison2Recoil: Int
    let poison2Reload: String?

    let recover1Clip: Int
    let recover1Rapid: Bool
    let recover1Recoil: Int
    let recover1Reload: String?

    let recover2Clip: Int
    let recover2Rapid: Bool
    let recover2Recoil: Int
    let recover2Reload: String?

    let sleep1Clip: Int
    let sleep1Rapid: Bool
    let sleep1Recoil: Int
    let sleep1Reload: String?

    let sleep2Clip: Int
    let sleep2Rapid: Bool
    let sleep2Recoil: Int
    let sleep2Reload: String?

    let slicingClip: Int
    let slicingRapid: Bool
    let slicingRecoil: Int
    let slicingReload: String?

    let spread1Clip: Int
    let spread1Rapid: Bool
    let spread1Recoil: Int
    let spread1Reload: String?

    let spread2Clip: Int
    let spread2Rapid: Bool
    let spread2Recoil: Int
    let spread2Reload: String?

    let spread3Clip: Int
    let spread3Rapid: Bool
    let spread3Recoil: Int
    let spread3Reload: String?

    let sticky1Clip: Int
    let sticky1Rapid: Bool
    let sticky1Recoil: Int
    let sticky1Reload: String?

    let sticky2Clip: Int
    let sticky2Rapid: Bool
    let sticky2Recoil: Int
    let sticky2Reload: String?

    let sticky3Clip: Int
    let sticky3Rapid: Bool
    let sticky3Recoil: Int
    let sticky3Reload: String?

    let thunderClip: Int
    let thunderRapid: Bool
    let thunderRecoil: Int
    let thunderReload: String?

    let waterClip: Int
    let waterRapid: Bool
    let waterRecoil: Int
    let waterReload: String?

    // 3s
    let armorClip: Int
    let armorRecoil: Int
    let armorReload: String?

    let demonClip: Int
    let demonRecoil: Int
    let demonReload: String?

    let tranqClip: Int
    let tranqRecoil: Int
    let tranqReload: String?

    let wyvernClip: Int
    let wyvernReload: String?

    var allValues: [AmmoValues] {
        [
        AmmoValues(text: "Normal 1", color: .white, clip: normal1Clip, rapid: normal1Rapid, recoil: normal1Recoil, reload: normal1Reload),
        AmmoValues(text: "Normal 2", color: .white, clip: normal2Clip, rapid: normal2Rapid, recoil: normal2Recoil, reload: normal2Reload),
        AmmoValues(text: "Normal 3", color: .white, clip: normal3Clip, rapid: normal3Rapid, recoil: normal3Recoil, reload: normal3Reload),
        AmmoValues(text: "Pierce 1", color: .blue, clip: pierce1Clip, rapid: pierce1Rapid, recoil: pierce1Recoil, reload: pierce1Reload),
        AmmoValues(text: "Pierce 2", color: .blue, clip: pierce2Clip, rapid: pierce2Rapid, recoil: pierce2Recoil, reload: pierce2Reload),
        AmmoValues(text: "Pierce 3", color: .blue, clip: pierce3Clip, rapid: pierce3Rapid, recoil: pierce3Recoil, reload: pierce3Reload),
        AmmoValues(text: "Spread 1", color: .darkGreen, clip: spread1Clip, rapid: spread1Rapid, recoil: spread1Recoil, reload: spread1Reload),
        AmmoValues(text: "Spread 2", color: .darkGreen, clip: spread2Clip, rapid: spread2Rapid, recoil: spread2Recoil, reload: spread2Reload),
        AmmoValues(text: "Spread 3", color: .darkGreen, clip: spread3Clip, rapid: spread3Rapid, recoil: spread3Recoil, reload: spread3Reload),
        AmmoValues(text: "Sticky 1", color: .beige, clip: sticky1Clip, rapid: sticky1Rapid, recoil: sticky1Recoil, reload: sticky1Reload),
        AmmoValues(text: "Sticky 2", color: .beige, clip: sticky2Clip, rapid: sticky2Rapid, recoil: sticky2Recoil, reload: sticky2Reload),
        AmmoValues(text: "Sticky 3", color: .beige, clip: sticky3Clip, rapid: sticky3Rapid, recoil: sticky3Recoil, reload: sticky3Reload),
        AmmoValues(text: "Cluster 1", color: .darkRed, clip: cluster1Clip, rapid: cluster1Rapid, recoil: cluster1Recoil, reload: cluster1Reload),
        AmmoValues(text: "Cluster 2", color: .darkRed, clip: cluster2Clip, rapid: cluster2Rapid, recoil: cluster2Recoil, reload: cluster2Reload),
        AmmoValues(text: "Cluster 3", color: .darkRed, clip: cluster3Clip, rapid: cluster3Rapid, recoil: cluster3Recoil, reload: cluster3Reload),
        AmmoValues(text: "Recover 1", color: .green, clip: recover1Clip, rapid: recover1Rapid, recoil: recover1Recoil, reload: recover1Reload),
        AmmoValues(text: "Recover 2", color: .green, clip: recover2Clip, rapid: recover2Rapid, recoil: recover2Recoil, reload: recover2Reload),
        AmmoValues(text: "Poison 1", color: .violet, clip: poison1Clip, rapid: poison1Rapid, recoil: poison1Recoil, reload: poison1Reload),
        AmmoValues(text: "Poison 2", color: .violet, clip: poison2Clip, rapid: poison2Rapid, recoil: poison2Recoil, reload: poison2Reload),
        AmmoValues(text: "Paralysis 1", color: .yellow, clip: paralysis1Clip, rapid: paralysis1Rapid, recoil: paralysis1Recoil, reload: paralysis1Reload),
        AmmoValues(text: "Paralysis 2", color: .yellow, clip: paralysis2Clip, rapid: paralysis2Rapid, recoil: paralysis2Recoil, reload: paralysis2Reload),
        AmmoValues(text: "Sleep 1", color: .cyan, clip: sleep1Clip, rapid: sleep1Rapid, recoil: sleep1Recoil, reload: sleep1Reload),
        AmmoValues(text: "Sleep 2", color: .cyan, clip: sleep2Clip, rapid: sleep2Rapid, recoil: sleep2Recoil, reload: sleep2Reload),
        AmmoValues(text: "Exhaust 1", color: .darkPurple, clip: exhaust1Clip, rapid: exhaust1Rapid, recoil: exhaust1Recoil, reload: exhaust1Reload),
        AmmoValues(text: "Exhaust 2", color: .darkPurple, clip: exhaust2Clip, rapid: exhaust2Rapid, recoil: exhaust2Recoil, reload: exhaust2Reload),
        AmmoValues(text: "Flaming", color: .orange, clip: flamingClip, rapid: flamingRapid, recoil: flamingRecoil, reload: flamingReload),
        AmmoValues(text: "Water", color: .darkPurple, clip: waterClip, rapid: waterRapid, recoil: waterRecoil, reload: waterReload),
        AmmoValues(text: "Freeze", color: .white, clip: freezeClip, rapid: freezeRapid, recoil: freezeRecoil, reload: freezeReload),
        AmmoValues(text: "Thunder", color: .gold, clip: thunderClip, rapid: thunderRapid, recoil: thunderRecoil, reload: thunderReload),
        AmmoValues(text: "Dragon", color: .darkRed, clip: dragonClip, rapid: dragonRapid, recoil: dragonRecoil, reload: dragonReload),
        AmmoValues(text: "Slicing", color: .white, clip: slicingClip, rapid: slicingRapid, recoil: slicingRecoil, reload: slicingReload),
        AmmoValues(text: "Wyvern", color: .lightBeige, clip: wyvernClip, rapid: true, recoil: 0, reload: wyvernReload),
        AmmoValues(text: "Demon", color: .red, clip: demonClip, recoil: demonRecoil, reload: demonReload),
        AmmoValues(text: "Armor", color: .beige, clip: armorClip, recoil: armorRecoil, reload: armorReload),
        AmmoValues(text: "Tranq", color: .pink, clip: tranqClip, recoil: tranqRecoil, reload: tranqReload)
        ].compactMap { $0 }
    }
}

struct AmmoValues: Identifiable {
    var id: String { return name }
    let name: String
    let icon: Icon
    let clip: Int
    let isRapid: Bool
    let recoil: Int?
    let reload: String?

    var shotType: String {
        if isRapid {
            return "Rapid"
        } else if recoil == -1 {
            return "Auto Reload"
        } else {
            return "Normal"
        }
    }

    var recoilString: String? {
        return recoil.flatMap { $0 > 0 ? $0.stringWithSymbol : nil }
    }

    init?(text: String?, iconName: String = "items_ammo", color: IconColor, clip: Int?, rapid: Bool? = false, recoil: Int?, reload: String?) {
        guard let text = text, let clip = clip, clip > 0 else { return nil }
        self.name = text
        self.icon = Icon(name: iconName, color: color)
        self.clip = clip
        self.isRapid = rapid ?? false
        self.recoil = recoil
        self.reload = reload?.replacingOccurrences(of: "very", with: "V.")
    }
}

extension Database {
    func ammo(ammoId: Int) -> Ammo? {
        let query = Query(table: "weapon_ammo", addLanguageFilter: false)
            .filter("id", equals: ammoId)
        return fetch(query).first
    }
}
