import UIKit

// MARK: AppCoordinator

final class AppCoordinator: BaseCoordinator {

    // MARK: - Internal Properties

    var childCoordinators: [BaseCoordinator] = []

    let navigationController: UINavigationController

    // MARK: - Life Cycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Internal Methods

    func start() {
        showMain()
    }

    // MARK: - Private Methods

    private func showMain() {
        let mainCoordinator = MainCoordinator(navigationController: navigationController)
        addChildCoordinator(mainCoordinator)
        mainCoordinator.start()
    }
}
