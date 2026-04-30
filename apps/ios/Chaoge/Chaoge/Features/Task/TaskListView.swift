import SwiftUI

struct TaskListView: View {
    private let tasks = TaskPreviewData.tasks

    private var activeTasks: [TaskPreview] {
        tasks.filter { $0.status != .completed && $0.status != .cancelled }
    }

    var body: some View {
        NavigationStack {
            ZStack {
                ChaogeColors.appBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                        ScreenHeader(
                            eyebrow: "TASK BOARD",
                            title: "任务看板",
                            subtitle: "展示当前战局的待办、进行中、阻塞与已完成任务。",
                            systemImage: "checklist.checked"
                        )

                        HStack(spacing: ChaogeTheme.Spacing.medium) {
                            MetricPill(title: "活跃任务", value: "\(activeTasks.count)", color: ChaogeColors.refractionCyan)
                            MetricPill(title: "总任务", value: "\(tasks.count)", color: ChaogeColors.refractionGold)
                        }

                        ForEach(tasks) { task in
                            TaskCard(task: task)
                        }

                        Spacer(minLength: 92)
                    }
                    .padding(.horizontal, ChaogeTheme.Spacing.large)
                    .padding(.top, ChaogeTheme.Spacing.xxlarge)
                    .padding(.bottom, ChaogeTheme.Spacing.xlarge)
                }
            }
            .navigationTitle("任务")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct TaskCard: View {
    let task: TaskPreview

    var body: some View {
        CrystalCard(isActive: task.status == .running) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
                HStack(alignment: .top, spacing: ChaogeTheme.Spacing.medium) {
                    Image(systemName: task.statusIcon)
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundStyle(task.statusColor)
                        .frame(width: 42, height: 42)
                        .background(Circle().fill(task.statusColor.opacity(0.14)))
                        .overlay(Circle().stroke(task.statusColor.opacity(0.32), lineWidth: ChaogeTheme.Stroke.crystal))

                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                        Text(task.title)
                            .font(ChaogeFonts.bodyStrong)
                            .foregroundStyle(ChaogeColors.textPrimary)

                        Text(task.detail)
                            .font(ChaogeFonts.small)
                            .foregroundStyle(ChaogeColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()
                }

                HStack(spacing: ChaogeTheme.Spacing.small) {
                    StatusBadge(text: task.statusText, color: task.statusColor)
                    StatusBadge(text: task.priorityText, color: task.priorityColor)
                    Spacer()
                    Text(task.owner)
                        .font(ChaogeFonts.caption)
                        .foregroundStyle(ChaogeColors.textTertiary)
                }
            }
        }
    }
}

private struct TaskPreview: Identifiable {
    let id: String
    let title: String
    let detail: String
    let status: TaskStatus
    let priority: TaskPriority
    let owner: String

    var statusText: String {
        switch status {
        case .pending:
            return "待办"
        case .running:
            return "进行中"
        case .blocked:
            return "阻塞"
        case .completed:
            return "已完成"
        case .cancelled:
            return "已取消"
        }
    }

    var statusIcon: String {
        switch status {
        case .pending:
            return "circle"
        case .running:
            return "play.circle.fill"
        case .blocked:
            return "exclamationmark.triangle.fill"
        case .completed:
            return "checkmark.seal.fill"
        case .cancelled:
            return "xmark.circle.fill"
        }
    }

    var statusColor: Color {
        switch status {
        case .pending:
            return ChaogeColors.textTertiary
        case .running:
            return ChaogeColors.refractionCyan
        case .blocked:
            return ChaogeColors.warning
        case .completed:
            return ChaogeColors.lifeGreen
        case .cancelled:
            return ChaogeColors.error
        }
    }

    var priorityText: String {
        switch priority {
        case .low:
            return "低"
        case .medium:
            return "中"
        case .high:
            return "高"
        case .urgent:
            return "急"
        }
    }

    var priorityColor: Color {
        switch priority {
        case .low:
            return ChaogeColors.textTertiary
        case .medium:
            return ChaogeColors.refractionBlue
        case .high:
            return ChaogeColors.refractionGold
        case .urgent:
            return ChaogeColors.error
        }
    }
}

private enum TaskPreviewData {
    static let tasks: [TaskPreview] = [
        TaskPreview(
            id: "mvp-tabs",
            title: "填充朝歌核心 Tab 内容",
            detail: "将聊天、项目、任务、设置从占位页升级为本地 MVP 页面。",
            status: .running,
            priority: .high,
            owner: "子牙"
        ),
        TaskPreview(
            id: "xcode-verify",
            title: "Mac/Xcode 编译验证",
            detail: "大王已确认 Build Succeeded，并可进入朝歌界面。",
            status: .completed,
            priority: .urgent,
            owner: "大王"
        ),
        TaskPreview(
            id: "real-agent-link",
            title: "接入真实 Agent 会话",
            detail: "待本地 MVP 稳定后，再连接 Hermes / OpenClaw 的真实服务。",
            status: .pending,
            priority: .medium,
            owner: "子牙 / 妲己"
        ),
        TaskPreview(
            id: "migration-execute",
            title: "迁都目标机执行",
            detail: "迁移包已备，仍需大王批准并在新硬件上执行。",
            status: .blocked,
            priority: .high,
            owner: "子牙"
        )
    ]
}

#Preview {
    TaskListView()
        .preferredColorScheme(.dark)
}
