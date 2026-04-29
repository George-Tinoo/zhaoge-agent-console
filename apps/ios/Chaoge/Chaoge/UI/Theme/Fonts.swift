import SwiftUI

enum ChaogeFonts {
    static let display = Font.system(size: 48, weight: .light, design: .rounded)
    static let h1 = Font.system(size: 32, weight: .semibold, design: .rounded)
    static let h2 = Font.system(size: 24, weight: .semibold, design: .rounded)
    static let h3 = Font.system(size: 20, weight: .medium, design: .rounded)
    static let body = Font.system(size: 16, weight: .regular, design: .default)
    static let small = Font.system(size: 14, weight: .regular, design: .default)
    static let caption = Font.system(size: 12, weight: .regular, design: .default)
    static let code = Font.system(size: 14, weight: .regular, design: .monospaced)
}

extension Text {
    func textGlow(color: Color = ChaogeColors.refractionCyan) -> some View {
        self
            .foregroundStyle(ChaogeColors.textPrimary)
            .shadow(color: color.opacity(0.5), radius: 10)
            .shadow(color: color.opacity(0.25), radius: 20)
    }
}
