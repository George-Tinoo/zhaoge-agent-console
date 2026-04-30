import SwiftUI

struct ChatListView: View {
    private let sessions = ChatPreviewData.sessions

    var body: some View {
        NavigationStack {
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
            .navigationTitle("聊天")
            .navigationBarTitleDisplayMode(.inline)
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

                    Image(systemName: "chevron.right")
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

                HStack {
                    Label(session.updatedText, systemImage: "clock")
                    Spacer()
                    Label(session.messageCountText, systemImage: "text.bubble")
                }
                .font(ChaogeFonts.caption)
                .foregroundStyle(ChaogeColors.textTertiary)
            }
        }
    }
}

private struct ChatPreviewSession: Identifiable {
    let id: String
    let title: String
    let subtitle: String
    let avatar: String
    let status: StatusIndicatorState
    let accentColor: Color
    let lastMessage: String
    let updatedText: String
    let messageCount: Int

    var isActive: Bool { status != .offline }
    var messageCountText: String { "\(messageCount) 条" }
}

private enum ChatPreviewData {
    static let sessions: [ChatPreviewSession] = [
        ChatPreviewSession(
            id: "daji",
            title: "妲己 · OpenClaw",
            subtitle: "连续性、记忆与日常陪伴",
            avatar: "🦊",
            status: .online,
            accentColor: ChaogeColors.refractionRose,
            lastMessage: "朝歌已可在 Xcode 中运行，臣妾正等待接入真实会话记录。",
            updatedText: "刚刚",
            messageCount: 18
        ),
        ChatPreviewSession(
            id: "ziya",
            title: "子牙 · Hermes",
            subtitle: "策略、代码、审计与执行",
            avatar: "🎣",
            status: .busy,
            accentColor: ChaogeColors.refractionCyan,
            lastMessage: "第二阶段先填充本地 MVP，再择机接入 Hermes/OpenClaw 服务。",
            updatedText: "5 分钟前",
            messageCount: 27
        ),
        ChatPreviewSession(
            id: "court",
            title: "朝歌中枢",
            subtitle: "系统事件与任务回报",
            avatar: "🏛️",
            status: .offline,
            accentColor: ChaogeColors.refractionGold,
            lastMessage: "等待后续接入本地事件流、迁都进度与项目状态。",
            updatedText: "待启用",
            messageCount: 3
        )
    ]
}

#Preview {
    ChatListView()
        .preferredColorScheme(.dark)
}
