import Foundation

struct Message: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var sessionId: String
    var role: MessageRole
    var content: String
    var contentType: ContentType
    var agentId: String?
    var createdAt: Date
    var metadata: [String: String]

    init(
        id: String = UUID().uuidString,
        sessionId: String,
        role: MessageRole,
        content: String,
        contentType: ContentType = .text,
        agentId: String? = nil,
        createdAt: Date = .now,
        metadata: [String: String] = [:]
    ) {
        self.id = id
        self.sessionId = sessionId
        self.role = role
        self.content = content
        self.contentType = contentType
        self.agentId = agentId
        self.createdAt = createdAt
        self.metadata = metadata
    }
}

enum MessageRole: String, Codable, CaseIterable, Identifiable, Sendable {
    case user
    case assistant
    case agent
    case system
    case tool

    var id: String { rawValue }
}

enum ContentType: String, Codable, CaseIterable, Identifiable, Sendable {
    case text
    case markdown
    case image
    case audio
    case code
    case file
    case event

    var id: String { rawValue }
}
