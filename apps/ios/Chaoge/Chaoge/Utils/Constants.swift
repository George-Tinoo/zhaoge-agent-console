import Foundation

/// Centralized application constants for Chaoge.
///
/// Values here are intentionally non-secret. Runtime credentials and user data
/// must remain in secure storage or injected configuration, never in source.
enum AppConstants {
    static let displayName = "朝歌"
    static let bundleIdentifier = "ai.chaoge.app"
    static let minimumIOSVersion = "17.0"
    static let defaultLocaleIdentifier = "zh_Hans_CN"
    static let supportEmail = "support@chaoge.ai"
}

enum NetworkConstants {
    static let defaultTimeoutSeconds: TimeInterval = 30
    static let maxRetryCount = 2
    static let jsonContentType = "application/json"
    static let userAgent = "Chaoge-iOS/1.0"
}

enum StorageConstants {
    static let appGroupIdentifier = "group.ai.chaoge.app"
    static let localDatabaseName = "chaoge.sqlite"
    static let cacheDirectoryName = "ChaogeCache"
    static let maxCacheAgeSeconds: TimeInterval = 60 * 60 * 24 * 7
}

enum UIConstants {
    static let animationScale: Double = 1.0
    static let maxReadableWidth: Double = 720
    static let defaultAvatarSymbol = "sparkles"
    static let hapticFeedbackEnabledByDefault = true
}
