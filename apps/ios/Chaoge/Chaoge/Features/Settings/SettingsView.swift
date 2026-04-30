import SwiftUI

struct SettingsView: View {
    private let sections = SettingsPreviewData.sections

    var body: some View {
        NavigationStack {
            ZStack {
                ChaogeColors.appBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                        ScreenHeader(
                            eyebrow: "LOCAL CONTROL",
                            title: "设置中枢",
                            subtitle: "当前为本地 MVP：展示环境、仓库与后续连接入口。",
                            systemImage: "gearshape.fill"
                        )

                        CrystalCard(isActive: true) {
                            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
                                HStack(spacing: ChaogeTheme.Spacing.medium) {
                                    Image(systemName: "iphone.gen3.radiowaves.left.and.right")
                                        .font(.system(size: 28, weight: .semibold))
                                        .foregroundStyle(ChaogeColors.refractionCyan)

                                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                                        Text("朝歌 iOS MVP")
                                            .font(ChaogeFonts.h3)
                                            .foregroundStyle(ChaogeColors.textPrimary)

                                        Text("已通过 Xcode 构建与模拟器启动验证")
                                            .font(ChaogeFonts.small)
                                            .foregroundStyle(ChaogeColors.textSecondary)
                                    }
                                }

                                HStack(spacing: ChaogeTheme.Spacing.small) {
                                    StatusBadge(text: "本地预览", color: ChaogeColors.refractionCyan)
                                    StatusBadge(text: "Mock 数据", color: ChaogeColors.refractionGold)
                                }
                            }
                        }

                        ForEach(sections) { section in
                            SettingsSectionCard(section: section)
                        }

                        Spacer(minLength: 92)
                    }
                    .padding(.horizontal, ChaogeTheme.Spacing.large)
                    .padding(.top, ChaogeTheme.Spacing.xxlarge)
                    .padding(.bottom, ChaogeTheme.Spacing.xlarge)
                }
            }
            .navigationTitle("设置")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct SettingsSectionCard: View {
    let section: SettingsSectionPreview

    var body: some View {
        CrystalCard {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
                HStack(spacing: ChaogeTheme.Spacing.medium) {
                    Image(systemName: section.systemImage)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(section.accentColor)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(section.accentColor.opacity(0.14)))

                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                        Text(section.title)
                            .font(ChaogeFonts.bodyStrong)
                            .foregroundStyle(ChaogeColors.textPrimary)

                        Text(section.subtitle)
                            .font(ChaogeFonts.small)
                            .foregroundStyle(ChaogeColors.textSecondary)
                    }

                    Spacer()
                }

                VStack(spacing: ChaogeTheme.Spacing.small) {
                    ForEach(section.items) { item in
                        HStack(alignment: .top) {
                            Text(item.name)
                                .font(ChaogeFonts.caption)
                                .foregroundStyle(ChaogeColors.textTertiary)
                                .frame(width: 92, alignment: .leading)

                            Text(item.value)
                                .font(item.isMonospaced ? ChaogeFonts.code : ChaogeFonts.caption)
                                .foregroundStyle(ChaogeColors.textSecondary)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .textSelection(.enabled)
                        }
                    }
                }
                .padding(ChaogeTheme.Spacing.medium)
                .background(
                    RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                        .fill(ChaogeColors.siliconBase.opacity(0.26))
                )
            }
        }
    }
}

private struct SettingsSectionPreview: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let systemImage: String
    let accentColor: Color
    let items: [SettingsItemPreview]
}

private struct SettingsItemPreview: Identifiable {
    let id: String
    let name: String
    let value: String
    var isMonospaced: Bool = false
}

private enum SettingsPreviewData {
    static let sections: [SettingsSectionPreview] = [
        SettingsSectionPreview(
            id: "repository",
            title: "代码仓库",
            subtitle: "当前朝歌 iOS 工程来源",
            systemImage: "chevron.left.forwardslash.chevron.right",
            accentColor: ChaogeColors.refractionCyan,
            items: [
                SettingsItemPreview(id: "repo", name: "GitHub", value: "George-Tinoo/zhaoge-agent-console", isMonospaced: true),
                SettingsItemPreview(id: "branch", name: "分支", value: "main", isMonospaced: true)
            ]
        ),
        SettingsSectionPreview(
            id: "agent-link",
            title: "Agent 连接",
            subtitle: "后续将从本地 mock 升级为真实服务",
            systemImage: "point.3.connected.trianglepath.dotted",
            accentColor: ChaogeColors.refractionGold,
            items: [
                SettingsItemPreview(id: "hermes", name: "子牙", value: "等待接入 Hermes API / 本地桥接"),
                SettingsItemPreview(id: "daji", name: "妲己", value: "等待接入 OpenClaw 工作区状态")
            ]
        ),
        SettingsSectionPreview(
            id: "runtime",
            title: "运行环境",
            subtitle: "当前推荐使用 iOS Simulator 验证",
            systemImage: "macbook.and.iphone",
            accentColor: ChaogeColors.lifeGreen,
            items: [
                SettingsItemPreview(id: "target", name: "目标", value: "iPhone Simulator"),
                SettingsItemPreview(id: "mode", name: "阶段", value: "第二阶段 MVP")
            ]
        )
    ]
}

#Preview {
    SettingsView()
        .preferredColorScheme(.dark)
}
