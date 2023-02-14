import UIKit

// MARK: SceneDelegate

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Internal Properties

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    static var shared: SceneDelegate! { UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate }

    // MARK: - Private Properties

    private(set) var serviceLocator: ServiceLocator!

    // MARK: - Internal Methods
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        serviceLocator = ServiceLocatorDefault(window: window, windowScene: windowScene)
        serviceLocator.start()
    }
}

