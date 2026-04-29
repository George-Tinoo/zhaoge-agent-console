import Foundation

struct User: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var phone: String
    var profile: UserProfile
    var preferences: UserPreferences
    var createdAt: Date
    var updatedAt: Date

    init(
        id: String = UUID().uuidString,
        phone: String,
        profile: UserProfile = UserProfile(),
        preferences: UserPreferences = UserPreferences(),
        createdAt: Date = .now,
        updatedAt: Date = .now
    ) {
        self.id = id
        self.phone = phone
        self.profile = profile
        self.preferences = preferences
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

struct UserProfile: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var nickname: String
    var avatarURL: URL?
    var bio: String?
    var location: String?

    init(
        id: String = UUID().uuidString,
        nickname: String = "大王",
        avatarURL: URL? = nil,
        bio: String? = nil,
        location: String? = nil
    ) {
        self.id = id
        self.nickname = nickname
        self.avatarURL = avatarURL
        self.bio = bio
        self.location = location
    }
}

struct UserPreferences: Codable, Identifiable, Equatable, Sendable {
    enum ColorSchemePreference: String, Codable, CaseIterable, Identifiable, Sendable {
        case system
        case light
        case dark

        var id: String { rawValue }
    }

    let id: String
    var preferredLanguage: String
    var enableHaptics: Bool
    var enableNotifications: Bool
    var colorScheme: ColorSchemePreference

    init(
        id: String = UUID().uuidString,
        preferredLanguage: String = "zh-Hans",
        enableHaptics: Bool = true,
        enableNotifications: Bool = true,
        colorScheme: ColorSchemePreference = .dark
    ) {
        self.id = id
        self.preferredLanguage = preferredLanguage
        self.enableHaptics = enableHaptics
        self.enableNotifications = enableNotifications
        self.colorScheme = colorScheme
    }
}
