import SwiftUI

/// Compatibility root view kept for the original project skeleton contract.
///
/// The production app currently enters through `ChaogeApp -> MainTabView`, but
/// retaining `ContentView` keeps SwiftUI previews, starter templates, and early
/// documentation aligned without changing runtime navigation.
struct ContentView: View {
    var body: some View {
        MainTabView()
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
