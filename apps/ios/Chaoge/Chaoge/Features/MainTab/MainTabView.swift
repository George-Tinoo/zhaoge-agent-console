import SwiftUI

enum MainTab: String, CaseIterable, Identifiable {
    case home
    case chat
    case project
    case task
    case settings

    var id: String { rawValue }

    var title: String {
        switch self {
        case .home:
            return "首页"
        case .chat:
            return "聊天"
        case .project:
            return "项目"
        case .task:
            return "任务"
        case .settings:
            return "设置"
        }
    }

    var systemImage: String {
        switch self {
        case .home:
            return "sparkles"
        case .chat:
            return "bubble.left.and.bubble.right"
        case .project:
            return "square.stack.3d.up"
        case .task:
            return "checklist"
        case .settings:
            return "gearshape"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            ChaogeColors.appBackground
                .ignoresSafeArea()

            Group {
                switch selectedTab {
                case .home:
                    HomeView()
                case .chat:
                    ChatListView()
                case .project:
                    ProjectListView()
                case .task:
                    TaskListView()
                case .settings:
                    SettingsView()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)

            customTabBar
        }
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                Button {
                    withAnimation(.easeOut(duration: 0.2)) {
                        selectedTab = tab
                    }
                } label: {
                    VStack(spacing: 5) {
                        Image(systemName: tab.systemImage)
                            .font(.system(size: 20, weight: .semibold))
                        Text(tab.title)
                            .font(ChaogeFonts.caption)
                    }
                    .foregroundStyle(selectedTab == tab ? ChaogeColors.refractionCyan : ChaogeColors.textSecondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 58)
                    .background {
                        if selectedTab == tab {
                            RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                                .fill(ChaogeColors.refractionCyan.opacity(0.1))
                                .shadow(color: ChaogeColors.refractionCyan.opacity(0.32), radius: 14)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, ChaogeTheme.Spacing.small)
        .padding(.vertical, ChaogeTheme.Spacing.small)
        .background {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .fill(.ultraThinMaterial)
                .overlay(ChaogeColors.siliconDark.opacity(0.78))
        }
        .overlay {
            RoundedRectangle(cornerRadius: 22, style: .continuous)
                .stroke(ChaogeColors.crystalBorder, lineWidth: ChaogeTheme.Stroke.crystal)
        }
        .padding(.horizontal, ChaogeTheme.Spacing.large)
        .padding(.bottom, ChaogeTheme.Spacing.small)
    }
}
