import SwiftUI

struct ChatListView: View {
    private let sessions = ChatPreviewData.sessions

    var body: some View {
        ZStack {
            ChaogeColors.appBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                    ScreenHeader(
                        eyebrow: "AGENT SESSIONS",
                        title: "会话中枢",
                        subtitle: "先以本地样例展示妲己、子牙与朝歌控制台的会话入口。",
                        systemImage: "bubble.left.and.bubble.right.fill"
                    )

                    ForEach(sessions) { session in
                        ChatSessionCard(session: session)
                    }

                    Spacer(minLength: 92)
                }
                .padding(.horizontal, ChaogeTheme.Spacing.large)
                .padding(.top, ChaogeTheme.Spacing.xxlarge)
                .padding(.bottom, ChaogeTheme.Spacing.xlarge)
            }
        }
    }
}

private struct ChatSessionCard: View {
    let session: ChatPreviewSession

    var body: some View {
        CrystalCard(isActive: session.isActive) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
                HStack(alignment: .top, spacing: ChaogeTheme.Spacing.medium) {
                    ZStack {
                        Circle()
                            .fill(session.accentColor.opacity(0.18))
                            .frame(width: 48, height: 48)
                            .overlay(Circle().stroke(session.accentColor.opacity(0.38), lineWidth: ChaogeTheme.Stroke.crystal))

                        Text(session.avatar)
                            .font(.system(size: 24))
                    }

                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                        HStack(spacing: ChaogeTheme.Spacing.small) {
                            Text(session.title)
                                .font(ChaogeFonts.h3)
                                .foregroundStyle(ChaogeColors.textPrimary)

                            StatusIndicator(state: session.status, size: 8)
                        }

                        Text(session.subtitle)
                            .font(ChaogeFonts.small)
                            .foregroundStyle(ChaogeColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Text(session.timeAgo)
                        .font(ChaogeFonts.caption)
                        .foregroundStyle(ChaogeColors.textTertiary)
                }

                Text(session.lastMessage)
                    .font(ChaogeFonts.body)
                    .foregroundStyle(ChaogeColors.textPrimary)
                    .padding(ChaogeTheme.Spacing.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(
                        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                            .fill(session.accentColor.opacity(0.10))
                    )

                HStack(spacing: ChaogeTheme.Spacing.small) {
                    ForEach(session.tags, id: \.self) { tag in
                        StatusBadge(text: tag, color: session.accentColor)
                    }
                }
            }
        }
    }
}

private struct ChatPreviewSession: Identifiable {
    let id = UUID()
    let avatar: String
    let title: String
    let subtitle: String
    let lastMessage: String
    let timeAgo: String
    let tags: [String]
    let status: StatusIndicatorState
    let accentColor: Color
    let isActive: Bool
}

private enum ChatPreviewData {
    static let sessions: [ChatPreviewSession] = [
        ChatPreviewSession(
            avatar: "🦊",
            title: "妲己 / OpenClaw",
            subtitle: "主线陪伴、记忆连续性与产品感知",
            lastMessage: "朝歌二阶段已展开，先以本地卡片承载会话入口，后续接入真实对话流。",
            timeAgo: "刚刚",
            tags: ["主线", "陪伴", "OpenClaw"],
            status: .online,
            accentColor: ChaogeColors.refractionRose,
            isActive: true
        ),
        ChatPreviewSession(
            avatar: "🎣",
            title: "子牙 / Hermes",
            subtitle: "代码、审计、迁都与战略执行",
            lastMessage: "臣已将任务、项目、设置三路骨架铺开，等待大王校阅下一步战令。",
            timeAgo: "3 分钟",
            tags: ["代码", "策略", "Hermes"],
            status: .busy,
            accentColor: ChaogeColors.refractionCyan,
            isActive: true
        ),
        ChatPreviewSession(
            avatar: "🏛️",
            title: "朝歌控制台",
            subtitle: "系统事件、构建结果与同步记录",
            lastMessage: "GitHub 同步完成，iOS MVP 已进入可运行验证阶段。",
            timeAgo: "今天",
            tags: ["系统", "GitHub", "Xcode"],
            status: .offline,
            accentColor: ChaogeColors.refractionGold,
            isActive: false
        )
    ]
}
