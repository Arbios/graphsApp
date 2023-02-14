import UIKit

// MARK: UIButton

extension UIButton {

    // MARK: - Internal Methods

    func setTitleWithoutAnimation(_ title: String?, for state: State) {
        setTitle(title, for: .normal)
        UIView.performWithoutAnimation {
            self.layoutIfNeeded()
        }
    }
}
