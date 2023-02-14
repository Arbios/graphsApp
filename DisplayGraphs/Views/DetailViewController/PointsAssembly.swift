import UIKit

// MARK: PointsAssembly

enum PointsAssembly {

    // MARK: - Types

    enum Error {
        case errorWhileSavingFile
        case errorWhileLoadingData
    }

    // MARK: - Internal Methods

    static func viewController(with delegate: PointsPresenterDelegate, count: Int) -> UIViewController {
        let vc = PointsVC()
        let presenter = PointsPresenterDefault(view: vc, count: count)
        presenter.delegate = delegate
        vc.presenter = presenter
        return vc
    }
}
