import SwiftUI

enum StatusIndicatorState {
    case online
    case busy
    case offline

    var color: Color {
        switch self {
        case .online:
            return ChaogeColors.refractionCyan
        case .busy:
            return ChaogeColors.refractionGold
        case .offline:
            return ChaogeColors.textTertiary
        }
    }
}

struct StatusIndicator: View {
    let state: StatusIndicatorState
    var size: CGFloat = 10

    @State private var isBreathing = false

    var body: some View {
        Circle()
            .fill(state.color)
            .frame(width: size, height: size)
            .overlay {
                Circle()
                    .stroke(state.color.opacity(0.45), lineWidth: 2)
                    .scaleEffect(isBreathing && state == .online ? 1.8 : 1)
                    .opacity(isBreathing && state == .online ? 0 : 0.8)
            }
            .shadow(color: state.color.opacity(state == .offline ? 0 : 0.6), radius: state == .online ? 10 : 5)
            .onAppear {
                isBreathing = true
            }
            .animation(ChaogeTheme.Animation.breathing, value: isBreathing)
    }
}
