import SwiftUI

enum ChaogeTheme {
    enum Radius {
        static let small: CGFloat = 8
        static let medium: CGFloat = 12
        static let large: CGFloat = 16
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
    }

    enum Animation {
        static let breathing = SwiftUI.Animation.easeInOut(duration: 1.8).repeatForever(autoreverses: true)
        static let quick = SwiftUI.Animation.easeOut(duration: 0.2)
    }
}
