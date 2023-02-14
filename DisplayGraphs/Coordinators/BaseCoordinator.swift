import SnapKit
import UIKit

// MARK: BaseCoordinator

protocol BaseCoordinator: AnyObject {
    var childCoordinators: [BaseCoordinator] { get set }
    var navigationController: UINavigationController { get }

    func start()
    func addChildCoordinator(_ coordinator: BaseCoordinator)
    func removeChildCoordinator(_ coordinator: BaseCoordinator)
    func popViewController(animated: Bool)
    func dismissViewController(animated: Bool, completion: (() -> Void)?)
}

extension BaseCoordinator {

    // MARK: - Internal Methods

    func addChildCoordinator(_ coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }

        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: BaseCoordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }

        childCoordinators.remove(at: index)
    }

    func startChild(coordinator: BaseCoordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else {
            return
        }

        childCoordinators.append(coordinator)
        coordinator.start()
    }

    func popViewController(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }

    func dismissViewController(animated: Bool, completion: (() -> Void)?) {
        navigationController.dismiss(animated: animated, completion: completion)
    }

    func setViewWith(
        _ viewController: UIViewController,
        type: CATransitionType = .fade,
        subtype: CATransitionSubtype? = .none,
        duration: CFTimeInterval = 0.2,
        isRoot: Bool = true
    ) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = type
        transition.subtype = subtype

        if isRoot {
            navigationController.view.layer.add(transition, forKey: nil)
            navigationController.setViewControllers([viewController], animated: false)
        } else {
            navigationController.view.layer.add(transition, forKey: nil)
            navigationController.pushViewController(viewController, animated: false)
        }
    }
}

// MARK: - BaseCoordinatorDefault

class BaseCoordinatorDefault: BaseCoordinator {

    // MARK: - Internal Properties

    var childCoordinators: [BaseCoordinator] = []

    let navigationController: UINavigationController

    // MARK: - Life Cycle

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Internal Methods

    func start() {}
}
