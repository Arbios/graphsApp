import UIKit

// MARK: CoordinatorServiceDefault

final class CoordinatorServiceDefault: CoordinatorService {

    // MARK: - Private Properties

    private weak var window: UIWindow!
    private weak var scene: UIWindowScene!

    private var appCoordinator: AppCoordinator!

    // MARK: - Life Cycle

    init(window: UIWindow, scene: UIWindowScene) {
        self.window = window
        self.scene = scene
    }

    // MARK: - Internal Methods
    
    func start() {
        let navigationVC = UINavigationController()
        let appCoordinator = AppCoordinator(navigationController: navigationVC)
        appCoordinator.start()

        self.appCoordinator = appCoordinator
        window.windowScene = scene
        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }

}
