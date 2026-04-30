import SwiftUI

struct ScreenHeader: View {
    let eyebrow: String
    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
            HStack(spacing: ChaogeTheme.Spacing.small) {
                Image(systemName: systemImage)
                    .font(ChaogeFonts.caption)
                    .foregroundStyle(ChaogeColors.refractionCyan)

                Text(eyebrow)
                    .font(ChaogeFonts.micro)
                    .foregroundStyle(ChaogeColors.refractionCyan)
                    .tracking(1.4)
            }

            Text(title)
                .font(ChaogeFonts.h1)
                .textGlow()

            Text(subtitle)
                .font(ChaogeFonts.small)
                .foregroundStyle(ChaogeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MetricPill: View {
    let title: String
    let value: String
    let color: Color

    var body: some View {
        CrystalCard(padding: ChaogeTheme.Spacing.medium) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                Text(title)
                    .font(ChaogeFonts.caption)
                    .foregroundStyle(ChaogeColors.textTertiary)

                Text(value)
                    .font(ChaogeFonts.h2)
                    .foregroundStyle(color)
                    .shadow(color: color.opacity(0.36), radius: 10)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct StatusBadge: View {
    let text: String
    let color: Color

    var body: some View {
        Text(text)
            .font(ChaogeFonts.caption)
            .foregroundStyle(color)
            .padding(.horizontal, ChaogeTheme.Spacing.medium)
            .padding(.vertical, ChaogeTheme.Spacing.xsmall)
            .background(
                Capsule(style: .continuous)
                    .fill(color.opacity(0.12))
            )
            .overlay(
                Capsule(style: .continuous)
                    .stroke(color.opacity(0.32), lineWidth: ChaogeTheme.Stroke.hairline)
            )
    }
}

#Preview {
    ZStack {
        ChaogeColors.appBackground.ignoresSafeArea()
        VStack(spacing: ChaogeTheme.Spacing.large) {
            ScreenHeader(
                eyebrow: "PREVIEW",
                title: "朝歌组件",
                subtitle: "复用页头、指标卡与状态标签。",
                systemImage: "sparkles"
            )
            HStack {
                MetricPill(title: "活跃", value: "4", color: ChaogeColors.refractionCyan)
                MetricPill(title: "完成", value: "1", color: ChaogeColors.lifeGreen)
            }
            StatusBadge(text: "推进中", color: ChaogeColors.refractionGold)
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
