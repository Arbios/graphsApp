import Foundation
import UIKit

// MARK: AssociatedKeys

private enum AssociatedKeys {
    static var applicationDidBecomeActive = UInt8(0)
    static var applicationWillResignActive = UInt8(0)
    static var applicationDidEnterBackground = UInt8(0)
    static var applicationWillEnterForeground = UInt8(0)
    static var applicationDidFinishLaunching = UInt8(0)
}

// MARK: - PublisherProxy (NotificationCenter)

extension PublisherProxy where Base: NotificationCenter {

    // MARK: - Types

    typealias PublisherType = Publisher<Notification>


    // MARK: - Internal Properties

    var applicationDidBecomeActive: PublisherType {
        publisherFor(name: UIApplication.didBecomeActiveNotification, key: &AssociatedKeys.applicationDidBecomeActive)
    }

    var applicationWillResignActive: PublisherType {
        publisherFor(name: UIApplication.willResignActiveNotification, key: &AssociatedKeys.applicationWillResignActive)
    }

    var applicationDidEnterBackground: PublisherType {
        publisherFor(
            name: UIApplication.didEnterBackgroundNotification,
            key: &AssociatedKeys.applicationDidEnterBackground
        )
    }

    var applicationWillEnterForeground: PublisherType {
        publisherFor(
            name: UIApplication.willEnterForegroundNotification,
            key: &AssociatedKeys.applicationWillEnterForeground
        )
    }

    var applicationDidFinishLaunching: PublisherType {
        publisherFor(
            name: UIApplication.didFinishLaunchingNotification,
            key: &AssociatedKeys.applicationDidFinishLaunching
        )
    }

    // MARK: - Private Methods

    private func publisherFor(name: Notification.Name, key: UnsafeRawPointer) -> PublisherType {
        if let result = objc_getAssociatedObject(base, key) as? PublisherType {
            return result
        }

        let result = PublisherType()
        _ = base.addObserver(forName: name, object: nil, queue: nil) { notification in
            result.send(notification)
        }
        objc_setAssociatedObject(base, key, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return result
    }
}
