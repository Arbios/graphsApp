import Foundation

// MARK: Publisher

class Publisher<Output> {

    // MARK: - Private Properties

    private var subscriptions = [UUID: (Output) -> Bool]()

    // MARK: - Life Cycle

    init() {}

    // MARK: - Internal Methods

    func send(_ value: Output) {
        subscriptions = subscriptions.filter { $0.value(value) }
    }

    @discardableResult
    func receive(in block: @escaping (Output) -> Void) -> Cancellable {
        return subscribe(self) { _, value in
            block(value)
        }
    }

    @discardableResult
    func receive(using object: AnyObject, in block: @escaping (Output) -> Void) -> Cancellable {
        return subscribe(object) { _, value in
            block(value)
        }
    }

    @discardableResult
    func callAsFunction(_ block: @escaping (Output) -> Void) -> Cancellable {
        return subscribe(self) { _, value in
            block(value)
        }
    }

    @discardableResult
    func send(to other: Publisher<Output>) -> Cancellable {
        return subscribe(other) { other, value in
            other.send(value)
        }
    }

    @discardableResult
    func assign<Root: AnyObject>(
        to keyPath: ReferenceWritableKeyPath<Root, Output>,
        on object: Root
    ) -> Cancellable {
        return subscribe(object) { object, value in
            object[keyPath: keyPath] = value
        }
    }

    // MARK: - Fileprivate Methods

    @discardableResult
    fileprivate func subscribe<Object: AnyObject>(
        _ object: Object,
        block: @escaping (Object, Output) -> Void
    ) -> Cancellable {
        let id = UUID()

        subscriptions[id] = { [weak object] value in
            guard let object = object else {
                return false
            }

            block(object, value)
            return true
        }

        return Cancellable { [weak self] in
            self?.subscriptions.removeValue(forKey: id)
        }
    }
}

// MARK: - ValuePublisher<Output>

class ValuePublisher<Output>: Publisher<Output> {

    // MARK: - Private Properties

    private let valueLock = FastLock()

    // MARK: - Internal Properties

    private(set) var value: Output

    var safeValue: Output {
        var result: Output!
        valueLock {
            result = value
        }

        return result
    }

    // MARK: - Life Cycle

    init(value: Output) {
        self.value = value
        super.init()
    }

    override func send(_ value: Output) {
        valueLock {
            self.value = value
        }
        super.send(value)
    }

    @discardableResult
    override func subscribe<Object: AnyObject>(
        _ object: Object,
        block: @escaping (Object, Output) -> Void
    ) -> Cancellable {
        block(object, value)
        return super.subscribe(object, block: block)
    }

    @discardableResult
    func receiveFirstSkip(using object: AnyObject, in block: @escaping (Output) -> Void) -> Cancellable {
        return subscribe(object) { _, value in
            block(value)
        }
    }
}

// MARK: - ValuePublisher (Equatable)

extension ValuePublisher where Output: Equatable {

    // MARK: - Internal Methods

    func sendIfNeeded(_ value: Output) {
        if self.value != value {
            send(value)
        }
    }

    @discardableResult
    func sendIfNeeded(to other: ValuePublisher<Output>) -> Cancellable {
        return subscribe(other) { other, value in
            other.sendIfNeeded(value)
        }
    }
}

// MARK: - ValuePublisher (Bool)

extension ValuePublisher where Output == Bool {

    // MARK: - Internal Methods

    func toggle() {
        send(!value)
    }
}

// MARK: - VoidPublisher

typealias VoidPublisher = Publisher<Void>

// MARK: - BoolPublisher

typealias BoolPublisher = Publisher<Bool>

// MARK: - BoolValuePublisher

typealias BoolValuePublisher = ValuePublisher<Bool>

// MARK: - Publisher (~>)
infix operator ~>

@discardableResult
func ~> <Output>(lhs: Publisher<Output>, rhs: Publisher<Output>) -> Cancellable {
    lhs.subscribe(rhs) { rhs, value in
        rhs.send(value)
    }
}

@discardableResult
func ~> <Base: AnyObject, Output>(
    lhs: Publisher<Output>,
    rhs: PublisherKeyPathValue<Base, Output>
) -> Cancellable {
    lhs.subscribe(rhs.base) { object, value in
        object[keyPath: rhs.keyPath] = value
    }
}
