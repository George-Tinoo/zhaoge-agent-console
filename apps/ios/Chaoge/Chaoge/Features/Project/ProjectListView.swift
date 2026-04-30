import SwiftUI

struct ProjectListView: View {
    private let projects = ProjectPreviewData.projects

    var body: some View {
        NavigationStack {
            ZStack {
                ChaogeColors.appBackground
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.large) {
                        ScreenHeader(
                            eyebrow: "PROJECT MATRIX",
                            title: "项目矩阵",
                            subtitle: "先以本地状态卡展示朝歌、迁都、妲己与子牙四条主线。",
                            systemImage: "square.stack.3d.up.fill"
                        )

                        ProjectOverviewRow(projects: projects)

                        ForEach(projects) { project in
                            ProjectCard(project: project)
                        }

                        Spacer(minLength: 92)
                    }
                    .padding(.horizontal, ChaogeTheme.Spacing.large)
                    .padding(.top, ChaogeTheme.Spacing.xxlarge)
                    .padding(.bottom, ChaogeTheme.Spacing.xlarge)
                }
            }
            .navigationTitle("项目")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

private struct ProjectOverviewRow: View {
    let projects: [ProjectPreview]

    private var activeCount: Int {
        projects.filter { $0.status == .active }.count
    }

    private var averageProgress: Int {
        guard !projects.isEmpty else { return 0 }
        let total = projects.map(\.progress).reduce(0, +)
        return total / projects.count
    }

    var body: some View {
        HStack(spacing: ChaogeTheme.Spacing.medium) {
            MetricPill(title: "活跃", value: "\(activeCount)", color: ChaogeColors.lifeGreen)
            MetricPill(title: "平均进度", value: "\(averageProgress)%", color: ChaogeColors.refractionCyan)
        }
    }
}

private struct ProjectCard: View {
    let project: ProjectPreview

    var body: some View {
        CrystalCard(isActive: project.status == .active) {
            VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.medium) {
                HStack(alignment: .top, spacing: ChaogeTheme.Spacing.medium) {
                    Image(systemName: project.systemImage)
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(project.accentColor)
                        .frame(width: 48, height: 48)
                        .background(Circle().fill(project.accentColor.opacity(0.14)))
                        .overlay(Circle().stroke(project.accentColor.opacity(0.36), lineWidth: ChaogeTheme.Stroke.crystal))

                    VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.xsmall) {
                        Text(project.name)
                            .font(ChaogeFonts.h3)
                            .foregroundStyle(ChaogeColors.textPrimary)

                        Text(project.summary)
                            .font(ChaogeFonts.small)
                            .foregroundStyle(ChaogeColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    StatusBadge(text: project.statusText, color: project.statusColor)
                }

                ProgressView(value: Double(project.progress), total: 100)
                    .tint(project.accentColor)
                    .background(ChaogeColors.siliconBase.opacity(0.35))
                    .clipShape(Capsule())

                HStack {
                    Label("\(project.progress)%", systemImage: "chart.line.uptrend.xyaxis")
                    Spacer()
                    Label(project.owner, systemImage: "person.crop.circle")
                }
                .font(ChaogeFonts.caption)
                .foregroundStyle(ChaogeColors.textTertiary)
            }
        }
    }
}

private struct ProjectPreview: Identifiable {
    let id: String
    let name: String
    let summary: String
    let status: ProjectStatus
    let progress: Int
    let owner: String
    let systemImage: String
    let accentColor: Color

    var statusText: String {
        switch status {
        case .active:
            return "推进中"
        case .paused:
            return "待令"
        case .completed:
            return "已成"
        case .archived:
            return "归档"
        }
    }

    var statusColor: Color {
        switch status {
        case .active:
            return ChaogeColors.lifeGreen
        case .paused:
            return ChaogeColors.refractionGold
        case .completed:
            return ChaogeColors.refractionCyan
        case .archived:
            return ChaogeColors.textTertiary
        }
    }
}

private enum ProjectPreviewData {
    static let projects: [ProjectPreview] = [
        ProjectPreview(
            id: "chaoge",
            name: "朝歌 · Agent Console",
            summary: "iOS 前端骨架已通，第二阶段填充核心 Tab 内容。",
            status: .active,
            progress: 28,
            owner: "子牙",
            systemImage: "iphone.gen3",
            accentColor: ChaogeColors.refractionCyan
        ),
        ProjectPreview(
            id: "migration",
            name: "迁都 · 新硬件迁移",
            summary: "最终迁移包已备，等待大王批准目标机执行。",
            status: .paused,
            progress: 86,
            owner: "子牙 / 妲己",
            systemImage: "externaldrive.connected.to.line.below",
            accentColor: ChaogeColors.refractionGold
        ),
        ProjectPreview(
            id: "daji",
            name: "妲己 · OpenClaw",
            summary: "负责连续性、工作区记忆与日常协作入口。",
            status: .active,
            progress: 64,
            owner: "妲己",
            systemImage: "sparkles",
            accentColor: ChaogeColors.refractionRose
        ),
        ProjectPreview(
            id: "hermes",
            name: "子牙 · Hermes",
            summary: "负责策略、审计、代码执行与跨会话调度。",
            status: .active,
            progress: 72,
            owner: "子牙",
            systemImage: "brain.head.profile",
            accentColor: ChaogeColors.lifeGreen
        )
    ]
}

#Preview {
    ProjectListView()
        .preferredColorScheme(.dark)
}
