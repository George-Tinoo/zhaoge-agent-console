import XCTest
@testable import Chaoge

final class InfrastructureModelsTests: XCTestCase {
    func testUserProfileAndPreferencesAreCodableAndIdentifiable() throws {
        let user = User(phone: "+8613800000000")
        let data = try JSONEncoder.chaogeTestEncoder.encode(user)
        let decoded = try JSONDecoder.chaogeTestDecoder.decode(User.self, from: data)

        XCTAssertEqual(decoded.id, user.id)
        XCTAssertEqual(decoded.profile.nickname, "大王")
        XCTAssertEqual(decoded.preferences.colorScheme, .dark)
    }

    func testDeviceDerivedResourceState() {
        let device = Device(
            name: "Lobster Pi",
            type: .lobsterPi,
            status: .online,
            storage: StorageInfo(totalBytes: 100, usedBytes: 40),
            resources: ResourceInfo(cpuUsage: 0.2, memoryUsage: 0.95)
        )

        XCTAssertTrue(device.isReachable)
        XCTAssertEqual(device.storage.freeBytes, 60)
        XCTAssertEqual(device.storage.usageRatio, 0.4)
        XCTAssertTrue(device.resources.isUnderPressure)
    }

    func testAgentSupervisorAndTaskPriorityOrdering() {
        let agent = Agent(name: "姜子牙", type: .supervisor, capabilities: ["strategy", "code"])
        XCTAssertTrue(agent.isSupervisor)
        XCTAssertTrue(agent.capabilities.contains("code"))
        XCTAssertTrue(TaskPriority.urgent > .high)
    }

    func testMessageSessionProjectAndTaskCodableRoundTrip() throws {
        let payload = Payload(
            message: Message(sessionId: "s1", role: .assistant, content: "臣在", contentType: .markdown),
            session: Session(title: "朝歌"),
            project: Project(name: "迁都"),
            task: TaskItem(title: "补全基础架构", priority: .high)
        )
        let data = try JSONEncoder.chaogeTestEncoder.encode(payload)
        let decoded = try JSONDecoder.chaogeTestDecoder.decode(Payload.self, from: data)

        XCTAssertEqual(decoded.message.role, .assistant)
        XCTAssertTrue(decoded.session.isActive)
        XCTAssertTrue(decoded.project.isOpen)
        XCTAssertFalse(decoded.task.isTerminal)
    }
}

private struct Payload: Codable, Equatable {
    let message: Message
    let session: Session
    let project: Project
    let task: TaskItem
}

private extension JSONEncoder {
    static var chaogeTestEncoder: JSONEncoder {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }
}

private extension JSONDecoder {
    static var chaogeTestDecoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }
}
