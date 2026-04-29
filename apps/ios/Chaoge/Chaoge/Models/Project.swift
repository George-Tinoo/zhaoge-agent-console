import Foundation

struct Project: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var name: String
    var summary: String
    var status: ProjectStatus
    var taskIds: [String]
    var ownerAgentId: String?
    var createdAt: Date
    var updatedAt: Date

    var isOpen: Bool {
        status == .active || status == .paused
    }

    init(
        id: String = UUID().uuidString,
        name: String,
        summary: String = "",
        status: ProjectStatus = .active,
        taskIds: [String] = [],
        ownerAgentId: String? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.status = status
        self.taskIds = taskIds
        self.ownerAgentId = ownerAgentId
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum ProjectStatus: String, Codable, CaseIterable, Identifiable, Sendable {
    case active
    case paused
    case completed
    case archived

    var id: String { rawValue }
}
