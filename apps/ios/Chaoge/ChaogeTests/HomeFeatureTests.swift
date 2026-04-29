import XCTest
@testable import Chaoge

@MainActor
final class HomeFeatureTests: XCTestCase {
    func testFortuneMockMatchesProductRequirement() {
        let fortune = Fortune.todayMock

        XCTAssertEqual(fortune.overall, 85)
        XCTAssertEqual(fortune.career, 90)
        XCTAssertEqual(fortune.wealth, 78)
        XCTAssertEqual(fortune.love, 82)
        XCTAssertEqual(fortune.health, 88)
        XCTAssertEqual(fortune.luckyColors, ["青色", "金色"])
        XCTAssertEqual(fortune.luckyNumbers, [3, 8])
    }

    func testFortuneScoresExposeNamedBreakdownItems() {
        let items = Fortune.todayMock.scoreItems

        XCTAssertEqual(items.map(\.title), ["事业", "财运", "情感", "健康"])
        XCTAssertEqual(items.map(\.score), [90, 78, 82, 88])
    }

    func testGreetingMessageChangesByHour() {
        XCTAssertEqual(GreetingView.greeting(forHour: 8), "早安")
        XCTAssertEqual(GreetingView.greeting(forHour: 14), "午安")
        XCTAssertEqual(GreetingView.greeting(forHour: 22), "晚安")
    }

    func testHomeViewModelLoadsFortuneAndStartsNewDay() async {
        let viewModel = HomeViewModel()
        XCTAssertNil(viewModel.fortune)

        await viewModel.loadFortune()
        XCTAssertEqual(viewModel.fortune, .todayMock)

        viewModel.startNewDay()
        XCTAssertEqual(viewModel.fortune, .todayMock)
        XCTAssertEqual(viewModel.actionTitle, "开启新的一天")
    }
}
