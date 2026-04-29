import XCTest
@testable import Chaoge

final class MainTabFeatureTests: XCTestCase {
    func testMainTabDefinesFiveProductTabsInOrder() {
        XCTAssertEqual(MainTab.allCases.map(\.title), ["首页", "聊天", "项目", "任务", "设置"])
        XCTAssertEqual(MainTab.allCases.map(\.rawValue), ["home", "chat", "project", "task", "settings"])
    }

    func testMainTabUsesExpectedSystemImages() {
        XCTAssertEqual(MainTab.home.systemImage, "house.fill")
        XCTAssertEqual(MainTab.chat.systemImage, "bubble.left.and.bubble.right.fill")
        XCTAssertEqual(MainTab.project.systemImage, "square.stack.3d.up.fill")
        XCTAssertEqual(MainTab.task.systemImage, "checklist.checked")
        XCTAssertEqual(MainTab.settings.systemImage, "gearshape.fill")
    }

    func testMainTabViewAndPlaceholderPagesCanBeConstructed() {
        _ = MainTabView()
        _ = ChatListView()
        _ = ProjectListView()
        _ = TaskListView()
        _ = SettingsView()
    }
}
