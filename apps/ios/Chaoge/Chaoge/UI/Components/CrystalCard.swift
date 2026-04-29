import SwiftUI

struct CrystalCard<Content: View>: View {
    private let content: Content
    private let padding: CGFloat

    init(padding: CGFloat = ChaogeTheme.Spacing.large, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.content = content()
    }

    var body: some View {
        content
            .padding(padding)
            .background {
                RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                    .fill(.ultraThinMaterial)
                    .overlay(ChaogeColors.crystalBackground)
            }
            .overlay {
                RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                    .stroke(ChaogeColors.crystalBorder, lineWidth: ChaogeTheme.Stroke.crystal)
            }
            .shadow(color: .black.opacity(0.22), radius: 24, x: 0, y: 10)
            .shadow(color: ChaogeColors.refractionCyan.opacity(0.08), radius: 18)
    }
}

#Preview {
    ZStack {
        ChaogeColors.appBackground.ignoresSafeArea()
        CrystalCard {
            Text("Crystal Card")
                .font(ChaogeFonts.h3)
                .foregroundStyle(ChaogeColors.textPrimary)
        }
    }
}
