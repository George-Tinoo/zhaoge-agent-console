import SwiftUI

struct FortuneView: View {
    let fortune: Fortune

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "zh_Hans_CN")
        formatter.dateFormat = "M月d日 EEEE"
        return formatter
    }()

    var body: some View {
        CrystalCard(isActive: true) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                header
                scoreBreakdown
                luckySection
            }
        }
        .accessibilityElement(children: .contain)
    }

    private var header: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                Text("今日运势")
                    .font(ChaogeFonts.h2)
                    .foregroundStyle(ChaogeColors.textPrimary)
                Text(dateFormatter.string(from: fortune.date))
                    .font(ChaogeFonts.small)
                    .foregroundStyle(ChaogeColors.textSecondary)
            }

            Spacer()

            VStack(spacing: 0) {
                Text("\(fortune.overall)")
                    .font(ChaogeFonts.display)
                    .foregroundStyle(ChaogeColors.infoRefraction)
                    .shadow(color: ChaogeColors.refractionCyan.opacity(0.38), radius: 16)
                Text("整体")
                    .font(ChaogeFonts.caption)
                    .foregroundStyle(ChaogeColors.textTertiary)
            }
            .accessibilityLabel("整体运势\(fortune.overall)分")
        }
    }

    private var scoreBreakdown: some View {
        VStack(spacing: ChaogeTheme.Spacing.medium) {
            ForEach(fortune.scoreItems) { item in
                FortuneScoreRow(item: item, color: color(for: item.kind))
            }
        }
    }

    private var luckySection: some View {
        HStack(alignment: .top, spacing: ChaogeTheme.Spacing.large) {
            FortuneTagGroup(title: "幸运色", values: fortune.luckyColors)
            FortuneTagGroup(title: "幸运数字", values: fortune.luckyNumbers.map(String.init))
        }
    }

    private func color(for kind: FortuneScoreItem.Kind) -> Color {
        switch kind {
        case .career:
            return ChaogeColors.refractionCyan
        case .wealth:
            return ChaogeColors.refractionGold
        case .love:
            return ChaogeColors.refractionRose
        case .health:
            return ChaogeColors.success
        }
    }
}

private struct FortuneScoreRow: View {
    let item: FortuneScoreItem
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
            HStack {
                Text(item.title)
                    .font(ChaogeFonts.small)
                    .foregroundStyle(ChaogeColors.textSecondary)
                Spacer()
                Text("\(item.score)")
                    .font(ChaogeFonts.bodyStrong)
                    .foregroundStyle(ChaogeColors.textPrimary)
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(ChaogeColors.siliconDark.opacity(0.8))
                    Capsule()
                        .fill(color)
                        .frame(width: max(0, min(proxy.size.width, proxy.size.width * CGFloat(item.score) / 100)))
                        .shadow(color: color.opacity(0.45), radius: 8)
                }
            }
            .frame(height: 7)
            .accessibilityLabel("\(item.title)\(item.score)分")
        }
    }
}

private struct FortuneTagGroup: View {
    let title: String
    let values: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.small) {
            Text(title)
                .font(ChaogeFonts.caption)
                .foregroundStyle(ChaogeColors.textTertiary)

            HStack(spacing: ChaogeTheme.Spacing.small) {
                ForEach(values, id: \.self) { value in
                    Text(value)
                        .font(ChaogeFonts.caption)
                        .foregroundStyle(ChaogeColors.textPrimary)
                        .padding(.horizontal, ChaogeTheme.Spacing.medium)
                        .padding(.vertical, 6)
                        .background(Capsule().fill(ChaogeColors.siliconLight.opacity(0.28)))
                        .overlay(Capsule().stroke(ChaogeColors.siliconPure.opacity(0.24), lineWidth: ChaogeTheme.Stroke.hairline))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
