import SwiftUI

extension Color {
    /// Creates a SwiftUI color from RGB, RGBA, or shorthand hex strings.
    /// Supported forms: #RGB, #RRGGBB, #RRGGBBAA.
    init(hex: String, opacity: Double = 1.0) {
        let sanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&value)

        let red: UInt64
        let green: UInt64
        let blue: UInt64
        let alpha: Double

        switch sanitized.count {
        case 3:
            red = ((value >> 8) & 0xF) * 17
            green = ((value >> 4) & 0xF) * 17
            blue = (value & 0xF) * 17
            alpha = opacity
        case 8:
            red = (value >> 24) & 0xFF
            green = (value >> 16) & 0xFF
            blue = (value >> 8) & 0xFF
            alpha = (Double(value & 0xFF) / 255.0) * opacity
        default:
            red = (value >> 16) & 0xFF
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
            alpha = opacity
        }

        self.init(
            .sRGB,
            red: Double(red) / 255.0,
            green: Double(green) / 255.0,
            blue: Double(blue) / 255.0,
            opacity: alpha
        )
    }
}

enum ChaogeColors {
    // MARK: - Silicon substrate

    static let voidBlack = Color(hex: "#070B12")
    static let siliconDark = Color(hex: "#101927")
    static let siliconBase = Color(hex: "#1B2A3A")
    static let siliconLight = Color(hex: "#35546A")
    static let siliconPure = Color(hex: "#A8C7D8")

    // MARK: - Living refraction spectrum

    static let refractionCyan = Color(hex: "#5CE1E6")
    static let refractionBlue = Color(hex: "#4A9EFF")
    static let refractionPurple = Color(hex: "#9B7EDE")
    static let refractionGold = Color(hex: "#D4AF37")
    static let refractionRose = Color(hex: "#E8A5C0")
    static let lifeGreen = Color(hex: "#5CE6A8")

    // MARK: - Semantic colors

    static let textPrimary = Color(hex: "#E8F1F5")
    static let textSecondary = Color(hex: "#9DB4C4")
    static let textTertiary = Color(hex: "#617989")
    static let error = Color(hex: "#FF6B7A")
    static let success = lifeGreen
    static let warning = Color(hex: "#F0A85C")

    // MARK: - Gradients

    static let appBackground = LinearGradient(
        colors: [voidBlack, siliconDark, siliconBase, Color(hex: "#101520")],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let crystalBackground = LinearGradient(
        colors: [
            siliconPure.opacity(0.18),
            siliconLight.opacity(0.10),
            siliconBase.opacity(0.36)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let infoRefraction = LinearGradient(
        colors: [refractionCyan, refractionBlue, refractionPurple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let energyRefraction = LinearGradient(
        colors: [refractionGold, Color(hex: "#F6E7A6"), refractionGold.opacity(0.78)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let lifeRefraction = LinearGradient(
        colors: [refractionRose, Color(hex: "#F4C2D4"), lifeGreen.opacity(0.88)],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let userBubbleRefraction = LinearGradient(
        colors: [Color(hex: "#37D6FF"), Color(hex: "#6B7CFF"), refractionPurple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let crystalBorder = LinearGradient(
        colors: [
            siliconPure.opacity(0.62),
            refractionCyan.opacity(0.42),
            refractionPurple.opacity(0.30),
            Color.white.opacity(0.18)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let crystalHighlight = LinearGradient(
        colors: [Color.white.opacity(0.28), Color.white.opacity(0.04), Color.clear],
        startPoint: .topLeading,
        endPoint: .center
    )
}
