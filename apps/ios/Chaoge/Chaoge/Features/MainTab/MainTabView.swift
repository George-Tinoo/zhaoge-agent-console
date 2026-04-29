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
            return "house.fill"
        case .chat:
            return "bubble.left.and.bubble.right.fill"
        case .project:
            return "square.stack.3d.up.fill"
        case .task:
            return "checklist.checked"
        case .settings:
            return "gearshape.fill"
        }
    }
}

struct MainTabView: View {
    @State private var selectedTab: MainTab = .home

    var body: some View {
        ZStack(alignment: .bottom) {
            ChaogeColors.siliconDark
                .ignoresSafeArea()

            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(MainTab.home)

                ChatListView()
                    .tag(MainTab.chat)

                ProjectListView()
                    .tag(MainTab.project)

                TaskListView()
                    .tag(MainTab.task)

                SettingsView()
                    .tag(MainTab.settings)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .ignoresSafeArea(.keyboard)

            customTabBar
        }
        .preferredColorScheme(.dark)
    }

    private var customTabBar: some View {
        HStack(spacing: 0) {
            ForEach(MainTab.allCases) { tab in
                Button {
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.78)) {
                        selectedTab = tab
                    }
                } label: {
                    MainTabItem(tab: tab, isSelected: selectedTab == tab)
                }
                .buttonStyle(.plain)
                .accessibilityLabel(tab.title)
                .accessibilityAddTraits(selectedTab == tab ? .isSelected : [])
            }
        }
        .padding(.horizontal, ChaogeTheme.Spacing.small)
        .padding(.vertical, ChaogeTheme.Spacing.small)
        .background {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(ChaogeColors.siliconDark.opacity(0.96))
                .background(
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(.ultraThinMaterial)
                )
                .overlay(
                    LinearGradient(
                        colors: [
                            ChaogeColors.refractionCyan.opacity(0.20),
                            ChaogeColors.crystalBorder.opacity(0.32),
                            ChaogeColors.refractionPurple.opacity(0.16)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .stroke(ChaogeColors.crystalBorder, lineWidth: ChaogeTheme.Stroke.crystal)
        }
        .shadow(color: ChaogeColors.refractionCyan.opacity(0.18), radius: 24, y: 8)
        .padding(.horizontal, ChaogeTheme.Spacing.large)
        .padding(.bottom, ChaogeTheme.Spacing.small)
    }
}

private struct MainTabItem: View {
    let tab: MainTab
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.system(size: 20, weight: .semibold))
                .symbolEffect(.bounce, value: isSelected)

            Text(tab.title)
                .font(ChaogeFonts.caption)
        }
        .foregroundStyle(isSelected ? ChaogeColors.refractionCyan : ChaogeColors.textPrimary.opacity(0.58))
        .frame(maxWidth: .infinity)
        .frame(height: 58)
        .background {
            if isSelected {
                RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                    .fill(ChaogeColors.refractionCyan.opacity(0.12))
                    .overlay(
                        RoundedRectangle(cornerRadius: ChaogeTheme.Radius.medium, style: .continuous)
                            .stroke(ChaogeColors.refractionCyan.opacity(0.34), lineWidth: ChaogeTheme.Stroke.hairline)
                    )
                    .shadow(color: ChaogeColors.refractionCyan.opacity(0.48), radius: 18)
            }
        }
    }
}

#Preview {
    MainTabView()
}
