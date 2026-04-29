import SwiftUI

struct CrystalInput: View {
    let placeholder: String
    @Binding var text: String
    var isVoiceInputActive: Bool = false

    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: ChaogeTheme.Spacing.medium) {
            TextField(placeholder, text: $text, axis: .vertical)
                .font(ChaogeFonts.body)
                .foregroundStyle(ChaogeColors.textPrimary)
                .tint(ChaogeColors.refractionCyan)
                .focused($isFocused)
                .lineLimit(1...4)

            Image(systemName: isVoiceInputActive ? "waveform.circle.fill" : "mic.circle")
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(isVoiceInputActive ? ChaogeColors.refractionCyan : ChaogeColors.textSecondary)
                .shadow(color: ChaogeColors.refractionCyan.opacity(isVoiceInputActive ? 0.6 : 0), radius: 10)
        }
        .padding(.horizontal, ChaogeTheme.Spacing.large)
        .padding(.vertical, ChaogeTheme.Spacing.medium)
        .background {
            RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                .fill(ChaogeColors.siliconDark.opacity(0.72))
        }
        .overlay {
            RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                .stroke(
                    isFocused ? ChaogeColors.refractionCyan.opacity(0.7) : ChaogeColors.siliconPure.opacity(0.24),
                    lineWidth: isFocused ? ChaogeTheme.Stroke.active : ChaogeTheme.Stroke.crystal
                )
        }
        .shadow(color: ChaogeColors.refractionCyan.opacity(isFocused ? 0.22 : 0), radius: 18)
        .animation(ChaogeTheme.Animation.quick, value: isFocused)
    }
}
