import Foundation

struct Device: Codable, Identifiable, Equatable {
    let id: String
    var name: String
    var type: DeviceType
    var status: DeviceStatus
    var storage: StorageInfo
    var resources: ResourceInfo
    var lastSeenAt: Date?

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

enum DeviceType: String, Codable, CaseIterable, Identifiable {
    case lobsterPi = "lobster_pi"
    case aiNPC = "ai_npc"
    case cloud

    var id: String { rawValue }
}

enum DeviceStatus: String, Codable, CaseIterable, Identifiable {
    case online
    case offline
    case busy

    var id: String { rawValue }
}

struct StorageInfo: Codable, Equatable {
    var totalBytes: Int64
    var usedBytes: Int64

    var usageRatio: Double {
        guard totalBytes > 0 else { return 0 }
        return Double(usedBytes) / Double(totalBytes)
    }

    init(totalBytes: Int64 = 0, usedBytes: Int64 = 0) {
        self.totalBytes = totalBytes
        self.usedBytes = usedBytes
    }
}

struct ResourceInfo: Codable, Equatable {
    var cpuUsage: Double
    var memoryUsage: Double
    var temperatureCelsius: Double?

    init(cpuUsage: Double = 0, memoryUsage: Double = 0, temperatureCelsius: Double? = nil) {
        self.cpuUsage = cpuUsage
        self.memoryUsage = memoryUsage
        self.temperatureCelsius = temperatureCelsius
    }
}
