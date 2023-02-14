import Foundation

// MARK: PublisherProxy

struct PublisherProxy<Base> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

// MARK: - PublisherProxySupport

protocol PublisherProxySupport {
    associatedtype PublisherProxyBase

    var pp: PublisherProxy<PublisherProxyBase> { get }
}

extension PublisherProxySupport {
    var pp: PublisherProxy<Self> { PublisherProxy(self) }
}

// MARK: - NSObject (PublisherProxySupport)

extension NSObject: PublisherProxySupport {
}

// MARK: - PublisherKeyPathProxy

struct PublisherKeyPathProxy<Base: AnyObject> {
    let base: Base

    init(_ base: Base) {
        self.base = base
    }
}

// MARK: - PublisherKeyPathProxySupport

protocol PublisherKeyPathProxySupport {
    associatedtype PublisherKeyPathProxyBase: AnyObject

    var kp: PublisherKeyPathProxy<PublisherKeyPathProxyBase> { get }
}

extension PublisherKeyPathProxySupport where Self: AnyObject {
    var kp: PublisherKeyPathProxy<Self> { PublisherKeyPathProxy(self) }
}

// MARK: - NSObject (PublisherKeyPathProxySupport)

extension NSObject: PublisherKeyPathProxySupport {
}

// MARK: - PublisherKeyPathValue

struct PublisherKeyPathValue<Base: AnyObject, Output> {
    let base: Base
    let keyPath: ReferenceWritableKeyPath<Base, Output>

    init(_ base: Base, keyPath: ReferenceWritableKeyPath<Base, Output>) {
        self.base = base
        self.keyPath = keyPath
    }
}
