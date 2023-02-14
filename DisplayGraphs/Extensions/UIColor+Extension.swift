import UIKit

// MARK: UIColor

extension UIColor {

    // MARK: - Lifecycle
    
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: a
        )
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// MARK: UIColor

extension UIColor {
    static let blueDotColor = UIColor(named: "BlueDotColor")!
    static let blueLineColor = UIColor(named: "BlueLineColor")!
    static let subTitleColor = UIColor(named: "SubTitleColor")!
    static let accentColor = UIColor(named: "AccentColor")!
    static let backgroundColor = UIColor(named: "BackgroundColor")!
}
