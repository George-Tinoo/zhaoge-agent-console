import SwiftUI

struct AgentAvatarView: View {
    @State private var isBreathing = false

    var body: some View {
        ZStack {
            Circle()
                .fill(ChaogeColors.refractionCyan.opacity(isBreathing ? 0.18 : 0.08))
                .frame(width: 164, height: 164)
                .blur(radius: 20)

            Circle()
                .fill(ChaogeColors.crystalBackground)
                .frame(width: 132, height: 132)
                .overlay {
                    Circle()
                        .stroke(ChaogeColors.crystalBorder, lineWidth: 1.4)
                }
                .shadow(color: ChaogeColors.refractionCyan.opacity(isBreathing ? 0.46 : 0.22), radius: isBreathing ? 28 : 14)

            Image(systemName: "sparkle.magnifyingglass")
                .font(.system(size: 46, weight: .light))
                .foregroundStyle(ChaogeColors.infoRefraction)
        }
        .scaleEffect(isBreathing ? 1.02 : 0.98)
        .onAppear {
            isBreathing = true
        }
        .animation(ChaogeTheme.Animation.breathing, value: isBreathing)
    }
}
