import Foundation

struct Session: Codable, Identifiable, Equatable {
    let id: String
    var title: String
    var status: SessionStatus
    var agentIds: [String]
    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        title: String,
        status: SessionStatus = .active,
        agentIds: [String] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.status = status
        self.agentIds = agentIds
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum SessionStatus: String, Codable, CaseIterable, Identifiable {
    case active
    case archived
    case closed

    var id: String { rawValue }
}
