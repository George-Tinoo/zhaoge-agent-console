import SwiftUI

enum SiliconButtonStyle {
    case primary
    case secondary
}

struct SiliconButton: View {
    let title: String
    var systemImage: String?
    var style: SiliconButtonStyle = .primary
    var action: () -> Void

    @State private var isBreathing = false

    var body: some View {
        Button(action: action) {
            HStack(spacing: ChaogeTheme.Spacing.small) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(ChaogeFonts.body.weight(.semibold))
            }
            .foregroundStyle(ChaogeColors.textPrimary)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(background)
            .overlay(border)
            .shadow(
                color: style == .primary ? ChaogeColors.refractionCyan.opacity(isBreathing ? 0.38 : 0.16) : .clear,
                radius: isBreathing ? 20 : 10
            )
            .opacity(isBreathing ? 1 : 0.88)
        }
        .buttonStyle(.plain)
        .onAppear {
            isBreathing = true
        }
        .animation(ChaogeTheme.Animation.breathing, value: isBreathing)
    }

    @ViewBuilder
    private var background: some View {
        if style == .primary {
            RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                .fill(ChaogeColors.infoRefraction)
        } else {
            RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                .fill(ChaogeColors.siliconBase.opacity(0.28))
        }
    }

    private var border: some View {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
            .stroke(
                style == .primary ? ChaogeColors.refractionCyan.opacity(0.35) : ChaogeColors.siliconPure.opacity(0.35),
                lineWidth: ChaogeTheme.Stroke.crystal
            )
    }
}
