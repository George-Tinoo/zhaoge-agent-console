import SwiftUI

struct AgentAvatarView: View {
    @State private var isBreathing = false

    var body: some View {
        VStack(spacing: ChaogeTheme.Spacing.medium) {
            ZStack {
                Circle()
                    .fill(ChaogeColors.refractionCyan.opacity(isBreathing ? 0.20 : 0.08))
                    .frame(width: 172, height: 172)
                    .blur(radius: 22)

                Circle()
                    .fill(.ultraThinMaterial.opacity(0.72))
                    .frame(width: 136, height: 136)
                    .background(Circle().fill(ChaogeColors.crystalBackground))
                    .overlay(Circle().stroke(ChaogeColors.crystalBorder, lineWidth: ChaogeTheme.Stroke.active))
                    .overlay(Circle().fill(ChaogeColors.crystalHighlight).blendMode(.screen))
                    .shadow(color: ChaogeColors.refractionCyan.opacity(isBreathing ? 0.48 : 0.22), radius: isBreathing ? 30 : 14)

                Image(systemName: "sparkle.magnifyingglass")
                    .font(.system(size: 46, weight: .light))
                    .foregroundStyle(ChaogeColors.infoRefraction)
                    .shadow(color: ChaogeColors.refractionCyan.opacity(0.35), radius: 10)
            }
            .scaleEffect(isBreathing ? 1.025 : 0.985)

            Text("朝歌中枢")
                .font(ChaogeFonts.caption)
                .foregroundStyle(ChaogeColors.textSecondary)
        }
        .onAppear { isBreathing = true }
        .animation(ChaogeTheme.Motion.breathing, value: isBreathing)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("朝歌中枢智能体头像")
    }
}
