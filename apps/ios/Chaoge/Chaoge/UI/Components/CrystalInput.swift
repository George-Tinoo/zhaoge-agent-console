import SwiftUI

struct CrystalInput: View {
    let placeholder: String
    @Binding var text: String
    var isVoiceInputActive: Bool = false
    var onSubmit: (() -> Void)?

    @FocusState private var isFocused: Bool
    @State private var isBreathing = false

    var body: some View {
        HStack(alignment: .bottom, spacing: ChaogeTheme.Spacing.medium) {
            TextField(placeholder, text: $text, axis: .vertical)
                .font(ChaogeFonts.body)
                .foregroundStyle(ChaogeColors.textPrimary)
                .tint(ChaogeColors.refractionCyan)
                .focused($isFocused)
                .lineLimit(1...4)
                .submitLabel(.send)
                .onSubmit { onSubmit?() }

            Image(systemName: isVoiceInputActive ? "waveform.circle.fill" : "mic.circle")
                .font(.system(size: 25, weight: .medium))
                .foregroundStyle(isVoiceInputActive ? ChaogeColors.refractionCyan : ChaogeColors.textSecondary)
                .scaleEffect(isVoiceInputActive && isBreathing ? 1.10 : 1.0)
                .shadow(color: ChaogeColors.refractionCyan.opacity(isVoiceInputActive ? 0.65 : 0), radius: 12)
                .accessibilityLabel(isVoiceInputActive ? "语音输入中" : "语音输入")
        }
        .padding(.horizontal, ChaogeTheme.Spacing.large)
        .padding(.vertical, ChaogeTheme.Spacing.medium)
        .background(inputShape.fill(ChaogeColors.siliconDark.opacity(0.76)))
        .background(inputShape.fill(.ultraThinMaterial.opacity(0.42)))
        .overlay(inputShape.stroke(borderColor, lineWidth: isFocused ? ChaogeTheme.Stroke.active : ChaogeTheme.Stroke.crystal))
        .shadow(color: ChaogeColors.refractionCyan.opacity(isFocused ? 0.24 : 0), radius: 18)
        .onAppear { isBreathing = true }
        .animation(ChaogeTheme.Motion.quick, value: isFocused)
        .animation(ChaogeTheme.Motion.breathing, value: isBreathing)
    }

    private var inputShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
    }

    private var borderColor: Color {
        if isVoiceInputActive { return ChaogeColors.refractionCyan.opacity(0.82) }
        return isFocused ? ChaogeColors.refractionCyan.opacity(0.72) : ChaogeColors.siliconPure.opacity(0.24)
    }
}
