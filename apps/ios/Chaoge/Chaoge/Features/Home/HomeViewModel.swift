import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var fortune: Fortune?
    @Published private(set) var isLoading = false
    @Published private(set) var lastStartedAt: Date?

    let actionTitle = "开启新的一天"

    func loadFortune() async {
        guard fortune == nil else { return }
        isLoading = true
        defer { isLoading = false }

        try? await Task.sleep(for: .milliseconds(120))
        fortune = .todayMock
    }

    func startNewDay() {
        lastStartedAt = .now
        fortune = .todayMock
    }
}
