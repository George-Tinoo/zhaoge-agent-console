import SwiftUI

struct GreetingView: View {
    private let hour: Int

    init(date: Date = .now, calendar: Calendar = .current) {
        self.hour = calendar.component(.hour, from: date)
    }

    static func greeting(forHour hour: Int) -> String {
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
            Text(Self.greeting(forHour: hour))
                .font(ChaogeFonts.h1)
                .textGlow()

            Text("水晶意识已校准，今天的能量正在折射。")
                .font(ChaogeFonts.body)
                .foregroundStyle(ChaogeColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .accessibilityElement(children: .combine)
    }
}
