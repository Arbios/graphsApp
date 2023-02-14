import UIKit

// MARK: ServiceLocator

protocol ServiceLocator: AnyObject {
    var window: UIWindow { get }
    var windowScene: UIWindowScene { get }
    var coordinator: CoordinatorService { get }

    func start()
    func resolve<T>(type: T.Type) -> T
}

// MARK: DefaultService: AnyObject

protocol DefaultService: AnyObject {
    func prepareForStart()
    func start()
}

// MARK: DefaultService

extension DefaultService {
    func prepareForStart() {}
    func start() {}
}

// MARK: - ServiceLocatorDefault

final class ServiceLocatorDefault: ServiceLocator {

    // MARK: - Internal Properties

    var window: UIWindow { _window }
    var windowScene: UIWindowScene { _windowScene }

    // MARK: - Private Properties

    private(set) lazy var coordinator: CoordinatorService = CoordinatorServiceDefault(window: _window, scene: _windowScene)
    private(set) lazy var api: APIService = APIServiceDefault(serviceLocator: self)
    private(set) lazy var storage: StorageService = StorageServiceDefault(serviceLocator: self)

    private weak var _window: UIWindow!
    private weak var _windowScene: UIWindowScene!

    private var services: [DefaultService] {
        return [coordinator, api, storage]
    }

    // MARK: - Life Cycle

    init(window: UIWindow!, windowScene: UIWindowScene!) {
        _window = window
        _windowScene = windowScene

        services.forEach { $0.prepareForStart() }
    }

    // MARK: - Internal Methods

    func start() {
        services.forEach { $0.start() }
    }

    func resolve<T>(type: T.Type) -> T {
        let mirror = Mirror(reflecting: self)
        if let result = mirror.children.map(\.value).compactMap({ $0 as? T }).first {
            return result
        }

        preconditionFailure("can't find type \(String(describing: T.self))")
    }
}
