import SwiftUI

struct CrystalCard<Content: View>: View {
    private let content: Content
    private let padding: CGFloat
    private let isActive: Bool

    init(
        padding: CGFloat = ChaogeTheme.Spacing.large,
        isActive: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.padding = padding
        self.isActive = isActive
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background(cardShape.fill(.ultraThinMaterial.opacity(ChaogeTheme.Opacity.glass)))
            .background(cardShape.fill(ChaogeColors.crystalBackground))
            .overlay(cardShape.fill(ChaogeColors.crystalHighlight).blendMode(.screen))
            .overlay(cardShape.stroke(ChaogeColors.crystalBorder, lineWidth: isActive ? ChaogeTheme.Stroke.active : ChaogeTheme.Stroke.crystal))
            .shadow(color: .black.opacity(0.28), radius: ChaogeTheme.Shadow.cardRadius, x: 0, y: 12)
            .shadow(color: ChaogeColors.refractionCyan.opacity(isActive ? 0.20 : 0.08), radius: isActive ? ChaogeTheme.Shadow.activeGlowRadius : ChaogeTheme.Shadow.glowRadius)
            .compositingGroup()
    }

    private var cardShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
    }
}

#Preview {
    ZStack {
        ChaogeColors.appBackground.ignoresSafeArea()
        CrystalCard(isActive: true) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.small) {
                Text("Silicon Life")
                    .font(ChaogeFonts.h3)
                    .textGlow()
                Text("水晶边框、毛玻璃、折射高光")
                    .font(ChaogeFonts.small)
                    .foregroundStyle(ChaogeColors.textSecondary)
            }
        }
        .padding()
    }
}
