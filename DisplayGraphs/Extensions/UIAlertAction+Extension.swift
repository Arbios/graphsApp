import UIKit

// MARK: UIAlertAction

extension UIAlertAction {

    // MARK: - Internal Properties

    static var cancel: UIAlertAction {
        .init(title: "Отмена", style: .cancel, handler: nil)
    }

    static var ok: UIAlertAction {
        .init(title: "Хорошо", style: .default, handler: nil)
    }
}
