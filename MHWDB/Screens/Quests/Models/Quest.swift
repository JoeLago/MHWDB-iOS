//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Quest: Decodable, FetchableRecord, Identifiable {
    var id: Int
    var name: String
    var description: String?
    var objective: String?
    var category: String?
    var questType: String?
    var stars: Int
    var starsRaw: Int
    var rank: Rank
    var locationId: Int
    var zenny: Int

    var icon: Icon? {
        switch questType {
        case "hunt": return Icon(name: "quest_hunt")
        case "slay": return Icon(name: "quest_slay")
        case "assignment": return Icon(name: "quest_assignment")
        case "deliver": return Icon(name: "quest_deliver")
        case "capture": return Icon(name: "quest_capture")
        default: return nil
        }
    }

    enum Rank: String, Equatable, Decodable {
        case low = "LR"
        case high = "HR"
        case master = "MR"

        var fullName: String {
            switch self {
            case .low: return "Low Rank"
            case .high: return "High Rank"
            case .master: return "Master Rank"
            }
        }

        var color: UIColor {
            switch self {
            case .low: return IconColor.blue.color
            case .high: return IconColor.red.color
            case .master: return IconColor.yellow.color
            }
        }
    }

    class func titleForStars(count: Int) -> String {
        guard count > 0 else { return "Training" }
        return String(repeating: String.star, count: count)
    }

    lazy var rewards: [QuestReward] = { return Database.shared.questRewards(questId: self.id) }()
    lazy var monsters: [QuestMonster] = { return Database.shared.monsters(questId: self.id) }()
    lazy var location: Location = { return Database.shared.location(id: locationId) }()
}

extension Database {

    func quest(id: Int) -> Quest {
        let query = Query(table: "quest").join(table: "quest_text").filter(id: id)
        return fetch(query)[0]
    }

    func quests(
        _ search: String? = nil,
        category: String? = nil,
        stars: Int? = nil
    ) -> [(stars: Int, quests: [Quest])] {

        let query = Query(table: "quest")
            .join(table: "quest_text")
            .order(by: "order_id")

        if let search = search { query.filter("name", contains: search) }
        if let category = category { query.filter("category", equals: category) }
        if let stars = stars { query.filter("stars", equals: stars) }

        let quests: [Quest] = fetch(query)

        var questsByStars = [Int: [Quest]]()
        for quest in quests {
            var questsForStars = questsByStars[quest.starsRaw] ?? []
            questsForStars.append(quest)
            questsByStars[quest.starsRaw] = questsForStars
        }

        return questsByStars.map { ($0.key, $0.value) }
    }

    func questCategories() -> [String] {
        return getStrings("SELECT category as value FROM quest GROUP BY category")
    }
}
