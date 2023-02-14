import Foundation

// MARK: - DI

@propertyWrapper struct Dependency<T> {

    // MARK: - Private Properties

    private let serviceLocator: ServiceLocator
    private let type: T.Type

    // MARK: - Internal Properties

    lazy var wrappedValue: T = serviceLocator.resolve(type: type)

    // MARK: - Life Cycle

    init(_ type: T.Type = T.self, serviceLocator: ServiceLocator = SceneDelegate.shared.serviceLocator) {
        self.type = T.self
        self.serviceLocator = serviceLocator
    }
}
