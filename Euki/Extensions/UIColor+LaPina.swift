import UIKit

/// UIColor extension providing La Piña brand colors and gradient utilities
/// Compatible with iOS 12.0+
extension UIColor {

    // MARK: - Primary Brand Colors

    /// Piña Pink - Primary color for main actions, headers, and active states
    /// Color: #E10098
    static var pinaPrimary: UIColor {
        return UIColor(red: 0.88, green: 0.00, blue: 0.60, alpha: 1.0)
    }

    /// Purple - Secondary color for secondary actions and accents
    /// Color: #8E44AD
    static var pinaSecondary: UIColor {
        return UIColor(red: 0.56, green: 0.27, blue: 0.68, alpha: 1.0)
    }

    /// Sunshine Yellow - For highlights, warnings, and premium badges
    /// Color: #FFD600
    static var pinaAccent: UIColor {
        return UIColor(red: 1.0, green: 0.84, blue: 0.0, alpha: 1.0)
    }

    /// Aqua Spiral - For fertility indicators and success states
    /// Color: #00BFB3
    static var pinaTeal: UIColor {
        return UIColor(red: 0.0, green: 0.75, blue: 0.70, alpha: 1.0)
    }

    // MARK: - Neutral Colors

    /// Pure white background color
    /// Color: #FFFFFF
    static var pinaWhite: UIColor {
        return UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

    /// Light gray for subtle backgrounds
    /// Color: #F5F5F5
    static var pinaLightGray: UIColor {
        return UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.0)
    }

    /// Medium gray for borders and dividers
    /// Color: #CCCCCC
    static var pinaGray: UIColor {
        return UIColor(red: 0.80, green: 0.80, blue: 0.80, alpha: 1.0)
    }

    /// Dark gray for secondary text
    /// Color: #666666
    static var pinaDarkGray: UIColor {
        return UIColor(red: 0.40, green: 0.40, blue: 0.40, alpha: 1.0)
    }

    /// Near black for primary text
    /// Color: #1A1A1A
    static var pinaBlack: UIColor {
        return UIColor(red: 0.10, green: 0.10, blue: 0.10, alpha: 1.0)
    }

    // MARK: - Gradient Helpers

    /// Creates a gradient layer with colors for use in views
    /// - Parameters:
    ///   - colors: Array of UIColor objects
    ///   - size: CGSize for the gradient layer
    ///   - startPoint: Start point of gradient (default: (0.0, 0.0))
    ///   - endPoint: End point of gradient (default: (1.0, 1.0))
    /// - Returns: CAGradientLayer configured with the specified colors
    static func createGradientLayer(
        with colors: [UIColor],
        size: CGSize,
        startPoint: CGPoint = CGPoint(x: 0.0, y: 0.0),
        endPoint: CGPoint = CGPoint(x: 1.0, y: 1.0)
    ) -> CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = CGRect(origin: .zero, size: size)
        return gradient
    }

    /// Creates the primary La Piña gradient (Pink to Purple)
    /// - Parameters:
    ///   - size: CGSize for the gradient layer
    /// - Returns: CAGradientLayer with primary gradient
    static func pinaPrimaryGradient(size: CGSize) -> CAGradientLayer {
        return createGradientLayer(
            with: [.pinaPrimary, .pinaSecondary],
            size: size,
            startPoint: CGPoint(x: 0.0, y: 0.0),
            endPoint: CGPoint(x: 1.0, y: 1.0)
        )
    }

    /// Creates the sunset gradient (Yellow to Pink)
    /// - Parameters:
    ///   - size: CGSize for the gradient layer
    /// - Returns: CAGradientLayer with sunset gradient
    static func pinaSunsetGradient(size: CGSize) -> CAGradientLayer {
        return createGradientLayer(
            with: [.pinaAccent, .pinaPrimary],
            size: size,
            startPoint: CGPoint(x: 0.5, y: 0.0),
            endPoint: CGPoint(x: 0.5, y: 1.0)
        )
    }

    /// Creates the ocean gradient (Teal to Purple)
    /// - Parameters:
    ///   - size: CGSize for the gradient layer
    /// - Returns: CAGradientLayer with ocean gradient
    static func pinaOceanGradient(size: CGSize) -> CAGradientLayer {
        return createGradientLayer(
            with: [.pinaTeal, .pinaSecondary],
            size: size,
            startPoint: CGPoint(x: 1.0, y: 0.0),
            endPoint: CGPoint(x: 0.0, y: 1.0)
        )
    }

    // MARK: - Hex Initializer

    /// Initializes a UIColor from a hex string
    /// - Parameters:
    ///   - hex: Hex color string in format "#RRGGBB" or "RRGGBB"
    ///   - alpha: Alpha value (default: 1.0)
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hex = hex.trimmingCharacters(in: CharacterSet(charactersIn: "#"))
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
