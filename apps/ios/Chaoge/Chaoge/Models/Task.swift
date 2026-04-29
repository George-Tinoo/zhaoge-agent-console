import Foundation

struct TaskItem: Codable, Identifiable, Equatable {
    let id: String
    var title: String
    var detail: String
    var status: TaskStatus
    var priority: TaskPriority
    var assignedAgentId: String?
    var projectId: String?
    var dueAt: Date?
    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        title: String,
        detail: String = "",
        status: TaskStatus = .pending,
        priority: TaskPriority = .medium,
        assignedAgentId: String? = nil,
        projectId: String? = nil,
        dueAt: Date? = nil,
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.title = title
        self.detail = detail
        self.status = status
        self.priority = priority
        self.assignedAgentId = assignedAgentId
        self.projectId = projectId
        self.dueAt = dueAt
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum TaskStatus: String, Codable, CaseIterable, Identifiable {
    case pending
    case running
    case blocked
    case completed
    case cancelled

    var id: String { rawValue }
}

enum TaskPriority: String, Codable, CaseIterable, Identifiable {
    case low
    case medium
    case high
    case urgent

    var id: String { rawValue }
}
