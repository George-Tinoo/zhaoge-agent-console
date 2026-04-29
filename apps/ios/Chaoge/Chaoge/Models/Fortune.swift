import Foundation

struct Fortune: Codable, Identifiable, Equatable, Sendable {
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

    var scoreItems: [FortuneScoreItem] {
        [
            FortuneScoreItem(title: "事业", score: career, kind: .career),
            FortuneScoreItem(title: "财运", score: wealth, kind: .wealth),
            FortuneScoreItem(title: "情感", score: love, kind: .love),
            FortuneScoreItem(title: "健康", score: health, kind: .health)
        ]
    }

    static let todayMock = Fortune(
        id: "fortune-today-mock",
        overall: 85,
        career: 90,
        wealth: 78,
        love: 82,
        health: 88,
        luckyColors: ["青色", "金色"],
        luckyNumbers: [3, 8]
    )

    static let mock = todayMock
}

struct FortuneScoreItem: Codable, Identifiable, Equatable, Sendable {
    enum Kind: String, Codable, CaseIterable, Identifiable, Sendable {
        case career
        case wealth
        case love
        case health

        var id: String { rawValue }
    }

    let id: String
    var title: String
    var score: Int
    var kind: Kind

    init(id: String? = nil, title: String, score: Int, kind: Kind) {
        self.id = id ?? kind.rawValue
        self.title = title
        self.score = score
        self.kind = kind
    }
}
