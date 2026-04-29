import SwiftUI

extension Color {
    init(hex: String, opacity: Double = 1.0) {
        let sanitized = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: sanitized).scanHexInt64(&value)

        let red: UInt64
        let green: UInt64
        let blue: UInt64

        switch sanitized.count {
        case 3:
            red = (value >> 8) * 17
            green = ((value >> 4) & 0xF) * 17
            blue = (value & 0xF) * 17
        default:
            red = value >> 16
            green = (value >> 8) & 0xFF
            blue = value & 0xFF
        }

        self.init(
            .sRGB,
            red: Double(red) / 255,
            green: Double(green) / 255,
            blue: Double(blue) / 255,
            opacity: opacity
        )
    }
}

enum ChaogeColors {
    static let siliconBase = Color(hex: "#2A3F4D")
    static let siliconDark = Color(hex: "#1A2630")
    static let siliconLight = Color(hex: "#4A6B7C")
    static let siliconPure = Color(hex: "#8FA3B0")

    static let refractionCyan = Color(hex: "#5CE1E6")
    static let refractionPurple = Color(hex: "#9B7EDE")
    static let refractionGold = Color(hex: "#D4AF37")
    static let refractionRose = Color(hex: "#E8A5C0")

    static let textPrimary = Color(hex: "#E8F1F5")
    static let textSecondary = Color(hex: "#8FA3B0")
    static let textTertiary = Color(hex: "#5A7380")
    static let error = Color(hex: "#E85D5D")
    static let success = Color(hex: "#5CE6A8")
    static let warning = Color(hex: "#F0A85C")

    static let appBackground = LinearGradient(
        colors: [siliconDark, siliconBase, Color(hex: "#1E2D38")],
        startPoint: .top,
        endPoint: .bottom
    )

    static let crystalBackground = LinearGradient(
        colors: [
            siliconLight.opacity(0.15),
            siliconBase.opacity(0.25)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let infoRefraction = LinearGradient(
        colors: [refractionCyan, Color(hex: "#4A9EFF"), refractionPurple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let energyRefraction = LinearGradient(
        colors: [refractionGold, Color(hex: "#F0E68C"), refractionGold],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    static let lifeRefraction = LinearGradient(
        colors: [refractionRose, Color(hex: "#F4C2D4"), refractionRose],
        startPoint: .leading,
        endPoint: .trailing
    )

    static let crystalBorder = LinearGradient(
        colors: [
            siliconPure.opacity(0.45),
            refractionCyan.opacity(0.35),
            refractionPurple.opacity(0.25)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
}
