import UIKit

// MARK: MainAssembly

enum MainAssembly {

    // MARK: - Internal Methods

    static func viewController(with delegate: MainPresenterDelegate) -> MainVC {
        let vc = MainVC()
        let presenter = MainPresenterDefault(view: vc)
        presenter.delegate = delegate
        vc.presenter = presenter
        return vc
    }
}
