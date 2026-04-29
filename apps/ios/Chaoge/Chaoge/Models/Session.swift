import Foundation

struct Session: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var title: String
    var status: SessionStatus
    var agentIds: [String]
    var messageIds: [String]
    var createdAt: Date
    var updatedAt: Date

    var isActive: Bool {
        status == .active
    }

    init(
        id: String = UUID().uuidString,
        title: String,
        status: SessionStatus = .active,
        agentIds: [String] = [],
        messageIds: [String] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.status = status
        self.agentIds = agentIds
        self.messageIds = messageIds
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum SessionStatus: String, Codable, CaseIterable, Identifiable, Sendable {
    case active
    case paused
    case archived
    case closed

    var id: String { rawValue }
}
