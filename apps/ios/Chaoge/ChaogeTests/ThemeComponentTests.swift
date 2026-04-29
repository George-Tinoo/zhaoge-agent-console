import XCTest
import SwiftUI
@testable import Chaoge

final class ThemeComponentTests: XCTestCase {
    func testStatusIndicatorStateMetadataIsStable() {
        XCTAssertEqual(StatusIndicatorState.online.id, "online")
        XCTAssertEqual(StatusIndicatorState.busy.label, "忙碌")
        XCTAssertEqual(StatusIndicatorState.offline.label, "离线")
    }

    func testSiliconLifeThemeConstantsAreUsable() {
        XCTAssertGreaterThan(ChaogeTheme.Radius.large, ChaogeTheme.Radius.medium)
        XCTAssertGreaterThan(ChaogeTheme.Spacing.xxlarge, ChaogeTheme.Spacing.large)
        XCTAssertGreaterThan(ChaogeTheme.Shadow.activeGlowRadius, ChaogeTheme.Shadow.glowRadius)
    }

    func testMessageBubbleCanBeConstructedForUserAndAgentMessages() {
        let userMessage = Message(sessionId: "s1", role: .user, content: "大王有旨")
        let agentMessage = Message(sessionId: "s1", role: .assistant, content: "臣在")

        _ = MessageBubble(message: userMessage)
        _ = MessageBubble(message: agentMessage, agentColor: ChaogeColors.refractionGold)
    }

    func testCoreThemeComponentsCanBeConstructed() {
        _ = CrystalCard { Text("硅基生命") }
        _ = SiliconButton(title: "执行", systemImage: "bolt.fill") {}
        _ = StatusIndicator(state: .online, showLabel: true)
    }
}
