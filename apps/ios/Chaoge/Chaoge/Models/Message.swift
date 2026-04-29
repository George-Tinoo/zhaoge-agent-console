import Foundation

struct Message: Codable, Identifiable, Equatable {
    let id: String
    var sessionId: String
    var role: MessageRole
    var content: String
    var contentType: ContentType
    var agentId: String?
    var createdAt: Date

    init(
        id: String = UUID().uuidString,
        sessionId: String,
        role: MessageRole,
        content: String,
        contentType: ContentType = .text,
        agentId: String? = nil,
        createdAt: Date = .now
    ) {
        self.id = id
        self.sessionId = sessionId
        self.role = role
        self.content = content
        self.contentType = contentType
        self.agentId = agentId
        self.createdAt = createdAt
    }
}

enum MessageRole: String, Codable, CaseIterable, Identifiable {
    case user
    case agent
    case system

    var id: String { rawValue }
}

enum ContentType: String, Codable, CaseIterable, Identifiable {
    case text
    case image
    case audio
    case code
    case markdown

    var id: String { rawValue }
}
