import SwiftUI

enum SiliconButtonStyle {
    case primary
    case secondary
    case destructive
}

struct SiliconButton: View {
    let title: String
    var systemImage: String?
    var style: SiliconButtonStyle = .primary
    var isEnabled: Bool = true
    var action: () -> Void

    @State private var isBreathing = false
    @State private var isPressed = false

    var body: some View {
        Button(action: { if isEnabled { action() } }) {
            HStack(spacing: ChaogeTheme.Spacing.small) {
                if let systemImage {
                    Image(systemName: systemImage)
                        .font(.system(size: 16, weight: .semibold))
                }
                Text(title)
                    .font(ChaogeFonts.bodyStrong)
            }
            .foregroundStyle(foregroundColor)
            .frame(maxWidth: .infinity)
            .frame(height: 52)
            .background(buttonShape.fill(backgroundFill))
            .overlay(buttonShape.stroke(borderColor, lineWidth: ChaogeTheme.Stroke.crystal))
            .scaleEffect(isPressed ? 0.985 : 1.0)
            .opacity(isEnabled ? (isBreathing ? 1.0 : 0.90) : 0.45)
            .shadow(color: glowColor.opacity(glowOpacity), radius: isBreathing ? 22 : 10)
        }
        .buttonStyle(.plain)
        .disabled(!isEnabled)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
        .onAppear { isBreathing = true }
        .animation(ChaogeTheme.Motion.breathing, value: isBreathing)
        .animation(ChaogeTheme.Motion.spring, value: isPressed)
    }

    private var buttonShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
    }

    private var backgroundFill: AnyShapeStyle {
        switch style {
        case .primary:
            return AnyShapeStyle(ChaogeColors.infoRefraction)
        case .secondary:
            return AnyShapeStyle(ChaogeColors.siliconBase.opacity(0.34))
        case .destructive:
            return AnyShapeStyle(ChaogeColors.error.opacity(0.82))
        }
    }

    private var foregroundColor: Color {
        style == .secondary ? ChaogeColors.textPrimary : .white
    }

    private var borderColor: Color {
        switch style {
        case .primary:
            return ChaogeColors.refractionCyan.opacity(0.44)
        case .secondary:
            return ChaogeColors.siliconPure.opacity(0.35)
        case .destructive:
            return ChaogeColors.error.opacity(0.42)
        }
    }

    private var glowColor: Color {
        switch style {
        case .primary:
            return ChaogeColors.refractionCyan
        case .secondary:
            return ChaogeColors.siliconPure
        case .destructive:
            return ChaogeColors.error
        }
    }

    private var glowOpacity: Double {
        guard isEnabled else { return 0 }
        return style == .primary ? (isBreathing ? 0.34 : 0.14) : 0.10
    }
}
