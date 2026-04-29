import Combine
import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    @Published private(set) var fortune: Fortune?
    @Published private(set) var isLoading = false

    func loadFortune() async {
        guard fortune == nil else { return }
        isLoading = true
        defer { isLoading = false }

        try? await Task.sleep(for: .milliseconds(120))
        fortune = .mock
    }

    func startNewDay() {
        fortune = Fortune.mock
    }
}
