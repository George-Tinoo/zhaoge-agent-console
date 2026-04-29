import SwiftUI

struct PlaceholderScreen: View {
    let title: String
    let subtitle: String
    let systemImage: String

    init(title: String, subtitle: String = "硅基模块正在生长。", systemImage: String) {
        self.title = title
        self.subtitle = subtitle
        self.systemImage = systemImage
    }

    var body: some View {
        ZStack {
            ChaogeColors.siliconDark
                .ignoresSafeArea()

            VStack(spacing: ChaogeTheme.Spacing.large) {
                Image(systemName: systemImage)
                    .font(.system(size: 52, weight: .light))
                    .foregroundStyle(ChaogeColors.refractionCyan)
                    .shadow(color: ChaogeColors.refractionCyan.opacity(0.46), radius: 18)

                Text(title)
                    .font(ChaogeFonts.h1)
                    .foregroundStyle(ChaogeColors.textPrimary)
                    .textGlow(color: ChaogeColors.refractionCyan.opacity(0.34))

                Text(subtitle)
                    .font(ChaogeFonts.body)
                    .foregroundStyle(ChaogeColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, ChaogeTheme.Spacing.xlarge)
            }
            .padding(.bottom, 92)
        }
    }
}
