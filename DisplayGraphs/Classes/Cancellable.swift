import Foundation

// MARK: Cancellable

final class Cancellable {
    private let block: () -> Void

    init(block: @escaping () -> Void) {
        self.block = block
    }

    func cancel() {
        block()
    }
}

// MARK: - Optional (Cancellable)

extension Optional where Wrapped == Cancellable {

    mutating func cancel() {
        if case let .some(value) = self {
            value.cancel()
            self = .none
        }
    }
}
