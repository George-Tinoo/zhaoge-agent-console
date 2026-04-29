import SwiftUI

struct PlaceholderScreen: View {
    let title: String
    let systemImage: String

    var body: some View {
        ZStack {
            ChaogeColors.siliconDark
                .ignoresSafeArea()

            VStack(spacing: ChaogeTheme.Spacing.large) {
                Image(systemName: systemImage)
                    .font(.system(size: 40, weight: .light))
                    .foregroundStyle(ChaogeColors.refractionCyan)
                    .shadow(color: ChaogeColors.refractionCyan.opacity(0.45), radius: 18)

                Text(title)
                    .font(ChaogeFonts.h1)
                    .foregroundStyle(ChaogeColors.textPrimary)
            }
        }
        .padding(.bottom, 86)
    }
}
