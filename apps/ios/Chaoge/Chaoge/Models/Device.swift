import Foundation

struct Device: Codable, Identifiable, Equatable, Sendable {
    let id: String
    var name: String
    var type: DeviceType
    var status: DeviceStatus
    var storage: StorageInfo
    var resources: ResourceInfo
    var lastSeenAt: Date?

    var isReachable: Bool {
        status == .online || status == .busy
    }

    init(
        id: String = UUID().uuidString,
        name: String,
        type: DeviceType,
        status: DeviceStatus = .offline,
        storage: StorageInfo = StorageInfo(),
        resources: ResourceInfo = ResourceInfo(),
        lastSeenAt: Date? = nil
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.status = status
        self.storage = storage
        self.resources = resources
        self.lastSeenAt = lastSeenAt
    }
}

enum DeviceType: String, Codable, CaseIterable, Identifiable, Sendable {
    case lobsterPi = "lobster_pi"
    case aiNPC = "ai_npc"
    case mac
    case linux
    case cloud
    case unknown

    var id: String { rawValue }
}

enum DeviceStatus: String, Codable, CaseIterable, Identifiable, Sendable {
    case online
    case offline
    case busy
    case warning
    case error

    var id: String { rawValue }
}

struct StorageInfo: Codable, Equatable, Sendable {
    var totalBytes: Int64
    var usedBytes: Int64

    var freeBytes: Int64 {
        max(totalBytes - usedBytes, 0)
    }

    var usageRatio: Double {
        guard totalBytes > 0 else { return 0 }
        return min(max(Double(usedBytes) / Double(totalBytes), 0), 1)
    }

    init(totalBytes: Int64 = 0, usedBytes: Int64 = 0) {
        self.totalBytes = totalBytes
        self.usedBytes = usedBytes
    }
}

struct ResourceInfo: Codable, Equatable, Sendable {
    var cpuUsage: Double
    var memoryUsage: Double
    var gpuUsage: Double?
    var temperatureCelsius: Double?

    var isUnderPressure: Bool {
        cpuUsage >= 0.9 || memoryUsage >= 0.9 || (temperatureCelsius ?? 0) >= 85
    }

    init(
        cpuUsage: Double = 0,
        memoryUsage: Double = 0,
        gpuUsage: Double? = nil,
        temperatureCelsius: Double? = nil
    ) {
        self.cpuUsage = cpuUsage
        self.memoryUsage = memoryUsage
        self.gpuUsage = gpuUsage
        self.temperatureCelsius = temperatureCelsius
    }
}
