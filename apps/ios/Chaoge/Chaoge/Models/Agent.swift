import Foundation

struct Agent: Codable, Identifiable, Equatable {
    let id: String
    var name: String
    var avatar: String?
    var type: AgentType
    var status: AgentStatus
    var capabilities: [String]
    var roleDescription: String?

    var isSupervisor: Bool {
        type == .supervisor
    }

    init(
        id: String = UUID().uuidString,
        name: String,
        avatar: String? = nil,
        type: AgentType,
        status: AgentStatus = .offline,
        capabilities: [String] = [],
        roleDescription: String? = nil
    ) {
        self.id = id
        self.name = name
        self.avatar = avatar
        self.type = type
        self.status = status
        self.capabilities = capabilities
        self.roleDescription = roleDescription
    }
}

enum AgentType: String, Codable, CaseIterable, Identifiable {
    case supervisor
    case specialist

    var id: String { rawValue }
}

enum AgentStatus: String, Codable, CaseIterable, Identifiable {
    case online
    case offline
    case busy
    case thinking

    var id: String { rawValue }
}
