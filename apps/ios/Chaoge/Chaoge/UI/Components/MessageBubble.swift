import SwiftUI

struct MessageBubble: View {
    let message: Message
    var agentColor: Color = ChaogeColors.refractionPurple
    var maxWidth: CGFloat = 320

    var body: some View {
        HStack(alignment: .bottom, spacing: ChaogeTheme.Spacing.small) {
            if message.role == .user {
                Spacer(minLength: 48)
                bubbleContent
                    .background(userBackground)
                    .overlay(userBorder)
            } else {
                agentStripe
                bubbleContent
                    .background(agentBackground)
                    .overlay(agentBorder)
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
            .frame(maxWidth: maxWidth, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .shadow(color: Color.black.opacity(0.16), radius: 4, x: 0, y: 1)
    }

    private var userBackground: some View {
        bubbleShape
            .fill(ChaogeColors.userBubbleRefraction)
            .shadow(color: ChaogeColors.refractionCyan.opacity(0.24), radius: 16, x: 0, y: 6)
    }

    private var agentBackground: some View {
        bubbleShape
            .fill(.ultraThinMaterial.opacity(0.62))
            .background(bubbleShape.fill(ChaogeColors.siliconBase.opacity(0.44)))
            .shadow(color: agentColor.opacity(0.12), radius: 12, x: 0, y: 4)
    }

    private var userBorder: some View {
        bubbleShape.stroke(Color.white.opacity(0.22), lineWidth: ChaogeTheme.Stroke.hairline)
    }

    private var agentBorder: some View {
        bubbleShape.stroke(agentColor.opacity(0.30), lineWidth: ChaogeTheme.Stroke.crystal)
    }

    private var agentStripe: some View {
        Capsule()
            .fill(agentColor)
            .frame(width: 4)
            .shadow(color: agentColor.opacity(0.56), radius: 8)
            .padding(.vertical, ChaogeTheme.Spacing.xsmall)
    }

    private var bubbleShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.large, style: .continuous)
    }
}
