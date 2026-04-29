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
                    } else {
                        CrystalCard {
                            HStack(spacing: ChaogeTheme.Spacing.medium) {
                                ProgressView()
                                    .tint(ChaogeColors.refractionCyan)
                                Text("正在观测今日天象……")
                                    .font(ChaogeFonts.body)
                                    .foregroundStyle(ChaogeColors.textSecondary)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    SiliconButton(title: viewModel.actionTitle, systemImage: "sunrise.fill") {
                        viewModel.startNewDay()
                    }

                    Spacer(minLength: 92)
                }
                .padding(.horizontal, ChaogeTheme.Spacing.large)
                .padding(.top, ChaogeTheme.Spacing.xxlarge)
                .padding(.bottom, ChaogeTheme.Spacing.xlarge)
            }
        }
        .task {
            await viewModel.loadFortune()
        }
    }
}

#Preview {
    HomeView()
}
