import SwiftUI

enum ChaogeFonts {
    static let display = Font.system(size: 48, weight: .light, design: .rounded)
    static let h1 = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let h2 = Font.system(size: 24, weight: .semibold, design: .rounded)
    static let h3 = Font.system(size: 20, weight: .medium, design: .rounded)
    static let body = Font.system(size: 16, weight: .regular, design: .default)
    static let bodyStrong = Font.system(size: 16, weight: .semibold, design: .rounded)
    static let small = Font.system(size: 14, weight: .regular, design: .default)
    static let caption = Font.system(size: 12, weight: .medium, design: .rounded)
    static let micro = Font.system(size: 10, weight: .medium, design: .monospaced)
    static let code = Font.system(size: 14, weight: .regular, design: .monospaced)
}

extension Text {
    func textGlow(color: Color = ChaogeColors.refractionCyan, radius: CGFloat = 10) -> some View {
        self
            .foregroundStyle(ChaogeColors.textPrimary)
            .shadow(color: color.opacity(0.50), radius: radius)
            .shadow(color: color.opacity(0.24), radius: radius * 2)
    }
}
