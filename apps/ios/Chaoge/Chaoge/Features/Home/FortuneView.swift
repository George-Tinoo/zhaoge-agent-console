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
        CrystalCard {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                HStack {
                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                        Text("今日运势")
                            .font(ChaogeFonts.h2)
                            .foregroundStyle(ChaogeColors.textPrimary)
                        Text(dateFormatter.string(from: fortune.date))
                            .font(ChaogeFonts.small)
                            .foregroundStyle(ChaogeColors.textSecondary)
                    }

                    Spacer()

                    Text("\(fortune.overall)")
                        .font(ChaogeFonts.display)
                        .foregroundStyle(ChaogeColors.infoRefraction)
                        .shadow(color: ChaogeColors.refractionCyan.opacity(0.38), radius: 16)
                }

                VStack(spacing: ChaogeTheme.Spacing.medium) {
                    FortuneScoreRow(title: "事业", score: fortune.career, color: ChaogeColors.refractionCyan)
                    FortuneScoreRow(title: "财运", score: fortune.wealth, color: ChaogeColors.refractionGold)
                    FortuneScoreRow(title: "情感", score: fortune.love, color: ChaogeColors.refractionRose)
                    FortuneScoreRow(title: "健康", score: fortune.health, color: ChaogeColors.success)
                }

                HStack(spacing: ChaogeTheme.Spacing.large) {
                    FortuneTagGroup(title: "幸运色", values: fortune.luckyColors)
                    FortuneTagGroup(title: "幸运数字", values: fortune.luckyNumbers.map(String.init))
                }
            }
        }
    }
}

private struct FortuneScoreRow: View {
    let title: String
    let score: Int
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
            HStack {
                Text(title)
                    .font(ChaogeFonts.small)
                    .foregroundStyle(ChaogeColors.textSecondary)
                Spacer()
                Text("\(score)")
                    .font(ChaogeFonts.small.weight(.semibold))
                    .foregroundStyle(ChaogeColors.textPrimary)
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(ChaogeColors.siliconDark.opacity(0.8))
                    Capsule()
                        .fill(color)
                        .frame(width: max(0, proxy.size.width * CGFloat(score) / 100))
                        .shadow(color: color.opacity(0.45), radius: 8)
                }
            }
            .frame(height: 6)
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
                        .font(ChaogeFonts.caption.weight(.semibold))
                        .foregroundStyle(ChaogeColors.textPrimary)
                        .padding(.horizontal, ChaogeTheme.Spacing.medium)
                        .padding(.vertical, 6)
                        .background {
                            Capsule()
                                .fill(ChaogeColors.siliconLight.opacity(0.28))
                        }
                        .overlay {
                            Capsule()
                                .stroke(ChaogeColors.siliconPure.opacity(0.24), lineWidth: ChaogeTheme.Stroke.hairline)
                        }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
