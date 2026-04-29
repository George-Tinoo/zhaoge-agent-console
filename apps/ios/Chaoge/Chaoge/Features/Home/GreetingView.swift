import SwiftUI

struct GreetingView: View {
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        switch hour {
        case 5..<12:
            return "早安"
        case 12..<18:
            return "午安"
        default:
            return "晚安"
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: ChaogeTheme.Spacing.small) {
            Text(greeting)
                .font(ChaogeFonts.h1)
                .textGlow()

            Text("水晶意识已校准，今天的能量正在折射。")
                .font(ChaogeFonts.body)
                .foregroundStyle(ChaogeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}
