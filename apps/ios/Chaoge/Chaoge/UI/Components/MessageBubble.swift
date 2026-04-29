import SwiftUI

struct MessageBubble: View {
    let message: Message
    var agentColor: Color = ChaogeColors.refractionPurple

    var body: some View {
        HStack(alignment: .bottom) {
            if message.role == .user {
                Spacer(minLength: 48)
                bubbleContent
                    .background(userBackground)
            } else {
                agentStripe
                bubbleContent
                    .background(agentBackground)
                Spacer(minLength: 48)
            }
        }
    }

    private var bubbleContent: some View {
        Text(message.content)
            .font(ChaogeFonts.body)
            .foregroundStyle(ChaogeColors.textPrimary)
            .padding(.horizontal, ChaogeTheme.Spacing.large)
            .padding(.vertical, ChaogeTheme.Spacing.medium)
            .fixedSize(horizontal: false, vertical: true)
    }

    private var userBackground: some View {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
            .fill(ChaogeColors.infoRefraction)
            .overlay {
                RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                    .stroke(ChaogeColors.refractionCyan.opacity(0.38), lineWidth: ChaogeTheme.Stroke.crystal)
            }
    }

    private var agentBackground: some View {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
            .fill(ChaogeColors.siliconBase.opacity(0.42))
            .overlay {
                RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
                    .stroke(ChaogeColors.siliconPure.opacity(0.22), lineWidth: ChaogeTheme.Stroke.crystal)
            }
    }

    private var agentStripe: some View {
        Capsule()
            .fill(agentColor)
            .frame(width: 4)
            .shadow(color: agentColor.opacity(0.5), radius: 8)
    }
}
