import SwiftUI

enum ChaogeTheme {
    enum Radius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 18
        static let xlarge: CGFloat = 28
        static let capsule: CGFloat = 999
    }

    enum Spacing {
        static let xsmall: CGFloat = 4
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
        static let xlarge: CGFloat = 24
        static let xxlarge: CGFloat = 32
    }

    enum Stroke {
        static let hairline: CGFloat = 0.5
        static let crystal: CGFloat = 1
        static let active: CGFloat = 1.5
        static let glow: CGFloat = 2
    }

    enum Shadow {
        static let cardRadius: CGFloat = 24
        static let glowRadius: CGFloat = 18
        static let activeGlowRadius: CGFloat = 28
    }

    enum Motion {
        static let breathing = SwiftUI.Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)
        static let slowBreathing = SwiftUI.Animation.easeInOut(duration: 2.6).repeatForever(autoreverses: true)
        static let quick = SwiftUI.Animation.easeOut(duration: 0.2)
        static let spring = SwiftUI.Animation.spring(response: 0.34, dampingFraction: 0.82)
    }

    enum Opacity {
        static let glass: Double = 0.64
        static let inactive: Double = 0.72
        static let pressed: Double = 0.86
    }
}
