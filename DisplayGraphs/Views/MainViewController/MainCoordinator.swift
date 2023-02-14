import UIKit

// MARK: MainCoordinator

final class MainCoordinator: BaseCoordinatorDefault {

    // MARK: - Private Properties

    private lazy var mainVC: MainVC! = MainAssembly.viewController(with: self)


    // MARK: - Internal Methods

    override func start() {
        setViewWith(mainVC)
    }
}

// MARK: MainCoordinator: MainPresenterDelegate

extension MainCoordinator: MainPresenterDelegate {

    // MARK: - Internal Methods

    func mainPresenterShowPointsScreein(_ presenter: MainPresenter, count: Int) {
        let pointsVC = PointsAssembly.viewController(with: self, count: count)
        navigationController.pushViewController(pointsVC, animated: true)
    }
}

// MARK: MainCoordinator: PointsPresenterDelegate

extension MainCoordinator: PointsPresenterDelegate {}
