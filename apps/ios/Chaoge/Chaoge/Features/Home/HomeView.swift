import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            ChaogeColors.appBackground
                .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: ChaogeTheme.Spacing.xlarge) {
                    GreetingView()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    AgentAvatarView()
                        .padding(.top, ChaogeTheme.Spacing.small)

                    if let fortune = viewModel.fortune {
                        FortuneView(fortune: fortune)
                    }

                    SiliconButton(title: "开启新的一天", systemImage: "sunrise.fill") {
                        viewModel.startNewDay()
                    }

                    Spacer(minLength: 92)
                }
                .padding(.horizontal, ChaogeTheme.Spacing.large)
                .padding(.top, ChaogeTheme.Spacing.xxlarge)
            }
        }
        .task {
            await viewModel.loadFortune()
        }
    }
}
