import Foundation

// MARK: FastLock

final class FastLock {

    // MARK: - Private Properties

    private var unfair_lock = os_unfair_lock()

    // MARK: - Internal Properties

    func callAsFunction(action: () -> Void) {
        sync(action: action)
    }

    func sync(action: () -> Void) {
        os_unfair_lock_lock(&unfair_lock)
        defer {
            os_unfair_lock_unlock(&unfair_lock)
        }

        action()
    }
}
