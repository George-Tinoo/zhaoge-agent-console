import Foundation

struct Project: Codable, Identifiable, Equatable {
    let id: String
    var name: String
    var summary: String
    var status: ProjectStatus
    var taskIds: [String]
    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        name: String,
        summary: String = "",
        status: ProjectStatus = .active,
        taskIds: [String] = [],
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.name = name
        self.summary = summary
        self.status = status
        self.taskIds = taskIds
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

enum ProjectStatus: String, Codable, CaseIterable, Identifiable {
    case active
    case paused
    case completed
    case archived

    var id: String { rawValue }
}
