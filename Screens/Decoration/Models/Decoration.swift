//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import GRDB

class Decoration: Decodable, Identifiable, FetchableRecord {
    let id: Int
    let name: String
    let iconColor: IconColor?
    let slot: Int
    let rarity: Int

    let skilltreeId: Int
    let skilltreeLevel: Int
    let skilltree2Id: Int?
    let skilltree2Level: Int?

    let mysteriousFeystonePercent: Double
    let glowingFeystonePercent: Double
    let wornFeystonePercent: Double
    let warpedFeystonePercent: Double
    let ancientFeystonePercent: Double
    let carvedFeystonePercent: Double
    let sealedFeystonePercent: Double

    var icon: Icon? { return Icon(name: "decoration_\(slot)", color: iconColor) }

    var skillTrees: [(tree: Skilltree, level: Int)] { return [skilltree, skillTreeTwo].compactMap { $0 } }

    lazy var skilltree: (Skilltree, Int) = {
        return (Database.shared.skilltree(id: self.skilltreeId), skilltreeLevel)
    }()

    lazy var skillTreeTwo: (Skilltree, Int)? = {
        guard let skilltreeId = self.skilltree2Id,
            let skilltreeLevel = self.skilltree2Level
            else { return nil }
        return (Database.shared.skilltree(id: skilltreeId), skilltreeLevel)
    }()

    var feystoneRates: [FeystoneRate] {
        [
            FeystoneRate(title: "Mysterious", color: .white, percentage: mysteriousFeystonePercent),
            FeystoneRate(title: "Glowing", color: .blue, percentage: glowingFeystonePercent),
            FeystoneRate(title: "Worn", color: .orange, percentage: wornFeystonePercent),
            FeystoneRate(title: "Warped", color: .red, percentage: warpedFeystonePercent),
            FeystoneRate(title: "Ancient", color: .violet, percentage: ancientFeystonePercent),
            FeystoneRate(title: "Carved", color: .green, percentage: carvedFeystonePercent),
            FeystoneRate(title: "Sealed", color: .yellow, percentage: sealedFeystonePercent)
        ]
    }
}

struct FeystoneRate: Identifiable {
    var id: String { return title }
    let title: String
    let color: IconColor
    let percentage: Double
}

extension Database {
    func decoration(id: Int) -> Decoration {
        let query = Query(table: "decoration").join(table: "decoration_text").filter(id: id)
        return fetch(query)[0]
    }

    func decorations(_ search: String? = nil) -> [Decoration] {
        let query = Query(table: "decoration").join(table: "decoration_text").order(by: "name")
        if let search = search {
            query.filter("name", contains: search)
        }
        return fetch(query)
    }
}
