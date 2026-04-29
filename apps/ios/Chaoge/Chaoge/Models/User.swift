import Foundation

struct User: Codable, Identifiable, Equatable {
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

struct UserProfile: Codable, Equatable {
    var nickname: String?
    var avatar: String?
    var bio: String?
}

struct UserPreferences: Codable, Equatable {
    var preferredLanguage: String
    var enableHaptics: Bool
    var enableNotifications: Bool
    var colorScheme: String

    init(
        preferredLanguage: String = "zh-Hans",
        enableHaptics: Bool = true,
        enableNotifications: Bool = true,
        colorScheme: String = "dark"
    ) {
        self.preferredLanguage = preferredLanguage
        self.enableHaptics = enableHaptics
        self.enableNotifications = enableNotifications
        self.colorScheme = colorScheme
    }
}
