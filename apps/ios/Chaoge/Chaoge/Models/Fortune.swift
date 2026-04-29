import Foundation

struct Fortune: Codable, Identifiable, Equatable {
    let id: String
    var date: Date
    var overall: Int
    var career: Int
    var wealth: Int
    var love: Int
    var health: Int
    var luckyColors: [String]
    var luckyNumbers: [Int]

    init(
        id: String = UUID().uuidString,
        date: Date = .now,
        overall: Int,
        career: Int,
        wealth: Int,
        love: Int,
        health: Int,
        luckyColors: [String],
        luckyNumbers: [Int]
    ) {
        self.id = id
        self.date = date
        self.overall = overall
        self.career = career
        self.wealth = wealth
        self.love = love
        self.health = health
        self.luckyColors = luckyColors
        self.luckyNumbers = luckyNumbers
    }

    static let mock = Fortune(
        overall: 85,
        career: 90,
        wealth: 78,
        love: 82,
        health: 88,
        luckyColors: ["青色", "金色"],
        luckyNumbers: [3, 8]
    )
}
