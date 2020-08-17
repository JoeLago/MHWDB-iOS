//
// MIT License
// Copyright (c) Gathering Hall Studios
//

import Foundation
import GRDB

class Quest: Decodable, FetchableRecord, Identifiable {
    var id: Int
    var name: String?
    var category: String?
    var questType: String?
    var stars: Int
    var rank: String
    var locationId: Int
    var zenny: Int

    var icon: Icon? {
        switch questType {
        case "hunt": return Icon(name: "ui_quest_hunt")
        case "slay": return Icon(name: "ui_quest_slay")
        case "assignment": return Icon(name: "ui_quest_assignment")
        case "deliver": return Icon(name: "ui_quest_deliver")
        case "capture": return Icon(name: "ui_quest_capture")
        default: return nil
        }
    }

    enum Rank: String, Decodable {
        case low = "LR"
        case high = "HR"
        case master = "MR"
    }

    class func titleForStars(count: Int) -> String {
        guard count > 0 else { return "Training" }
        return String(repeating: String.star, count: count)
    }

    lazy var rewards: [QuestReward] = { return Database.shared.rewards(questId: self.id) }()
    lazy var prereqQuests: [Quest] = { return Database.shared.prereqQuests(questId: self.id) }()
    lazy var monsters: [QuestMonster] = { return Database.shared.monsters(questId: self.id) }()

    lazy var rewardsBySlot: [String: [QuestReward]] = {
        let allRewards = Database.shared.rewards(questId: self.id)
        var rewardsBySlot = [String: [QuestReward]]()
        for reward in allRewards {
            var slot = rewardsBySlot[reward.slot] ?? [QuestReward]()
            slot.append(reward)
            rewardsBySlot[reward.slot] = slot
        }
        return rewardsBySlot
    }()
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
            var questsForStars = questsByStars[quest.stars] ?? []
            questsForStars.append(quest)
            questsByStars[quest.stars] = questsForStars
        }

        return questsByStars.map { ($0.key, $0.value) }
    }

    func questCategories() -> [String] {
        return getStrings("SELECT category as value FROM quest GROUP BY category")
    }

    func prereqQuests(questId: Int) -> [Quest] {
        let query = "SELECT *, quest_prereqs.prereq_id as _id FROM quest_prereqs"
            + " LEFT JOIN quests ON quests._id = quest_prereqs.prereq_id"
            + " WHERE quest_id == \(questId)"
        return fetch(query)
    }
}
