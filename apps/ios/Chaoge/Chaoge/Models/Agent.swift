import Foundation

struct Agent: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var name: String
    var avatar: String?
    var type: AgentType
    var status: AgentStatus
    var capabilities: [String]
    var roleDescription: String?
    var modelName: String?

    var isSupervisor: Bool {
        type == .supervisor
    }

    var isAvailable: Bool {
        status == .online || status == .thinking
    }

    init(
        id: String = UUID().uuidString,
        name: String,
        avatar: String? = nil,
        type: AgentType,
        status: AgentStatus = .offline,
        capabilities: [String] = [],
        roleDescription: String? = nil,
        modelName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.type = type
        self.status = status
        self.capabilities = capabilities
        self.roleDescription = roleDescription
        self.modelName = modelName
    }
}

enum AgentType: String, Codable, CaseIterable, Identifiable, Sendable {
    case supervisor
    case strategist
    case coder
    case researcher
    case executor
    case specialist

    var id: String { rawValue }
}

enum AgentStatus: String, Codable, CaseIterable, Identifiable, Sendable {
    case online
    case offline
    case busy
    case thinking
    case error

    var id: String { rawValue }
}
