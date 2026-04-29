import SwiftUI

enum StatusIndicatorState: String, CaseIterable, Identifiable {
    case online
    case busy
    case offline

    var id: String { rawValue }

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

    var label: String {
        switch self {
        case .online:
            return "在线"
        case .busy:
            return "忙碌"
        case .offline:
            return "离线"
        }
    }
}

struct StatusIndicator: View {
    let state: StatusIndicatorState
    var size: CGFloat = 10
    var showLabel: Bool = false

    @State private var isBreathing = false

    var body: some View {
        HStack(spacing: ChaogeTheme.Spacing.small) {
            ZStack {
                if state != .offline {
                    Circle()
                        .stroke(state.color.opacity(state == .online ? 0.42 : 0.28), lineWidth: 2)
                        .scaleEffect(isBreathing ? (state == .online ? 1.85 : 1.35) : 1.0)
                        .opacity(isBreathing ? 0 : 0.72)
                }

                Circle()
                    .fill(state.color)
                    .frame(width: size, height: size)
                    .shadow(color: state.color.opacity(state == .offline ? 0 : 0.66), radius: state == .online ? 10 : 5)
            }
            .frame(width: size * 2, height: size * 2)

            if showLabel {
                Text(state.label)
                    .font(ChaogeFonts.caption)
                    .foregroundStyle(state == .offline ? ChaogeColors.textTertiary : ChaogeColors.textSecondary)
            }
        }
        .onAppear { isBreathing = true }
        .animation(state == .busy ? ChaogeTheme.Motion.slowBreathing : ChaogeTheme.Motion.breathing, value: isBreathing)
        .accessibilityLabel(state.label)
    }
}
