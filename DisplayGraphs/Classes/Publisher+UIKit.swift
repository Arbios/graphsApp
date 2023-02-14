import UIKit

// MARK: AssociatedKeys

private enum AssociatedKeys {
    static var targetsKey = UInt8(0)
    static var textKey = UInt8(0)
    static var attributedTextKey = UInt8(0)
    static var titleKey = UInt8(0)
}

// MARK: - PublisherProxy (UIButton)

extension PublisherProxy where Base: UIButton {
    var normalTitle: Publisher<String?> {
        if let result = objc_getAssociatedObject(base, &AssociatedKeys.titleKey) as? Publisher<String?> {
            return result
        }

        let result = Publisher<String?>()
        result { [weak base] title in
            base?.setTitleWithoutAnimation(title, for: .normal)
        }
        objc_setAssociatedObject(base, &AssociatedKeys.titleKey, result, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return result
    }
}

// MARK: - UIControl ()

private extension UIControl {
    final class ControlTarget<Control: UIControl>: NSObject {
        typealias Callback = (UIControl) -> Void

        weak var control: Control!
        let event: Event
        let publisher = Publisher<Control>()

        init(control: Control, event: UIControl.Event) {
            self.control = control
            self.event = event

            super.init()

            control.addTarget(self, action: #selector(eventHandler(_:)), for: event)
        }

        deinit {
            control?.removeTarget(self, action: #selector(eventHandler(_:)), for: event)
        }

        // MARK: Events
        @objc private func eventHandler(_ sender: UIControl) {
            publisher.send(sender as! Control)
        }
    }
}

// MARK: - PublisherProxy (UIControl)

extension PublisherProxy where Base: UIControl {
    private typealias BaseControlTarget = UIControl.ControlTarget<Base>
    typealias BasePublisher = Publisher<Base>

    var tap: BasePublisher { controlEvent(.touchUpInside) }
    var editingChanged: BasePublisher { controlEvent(.editingChanged) }
    var valueChanged: BasePublisher { controlEvent(.valueChanged) }

    func controlEvent(_ event: UIControl.Event) -> BasePublisher {
        var targets = objc_getAssociatedObject(base, &AssociatedKeys.targetsKey) as? [BaseControlTarget] ?? []
        if let result = targets.first(where: { $0.event == event }) {
            return result.publisher
        }

        let result = BaseControlTarget(control: base, event: event)
        targets.append(result)
        objc_setAssociatedObject(base, &AssociatedKeys.targetsKey, targets, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return result.publisher
    }
}

// MARK: - UIBarButtonItem ()

private extension UIBarButtonItem {
    final class Target: NSObject {
        weak var barButtonItem: UIBarButtonItem!
        let publisher = VoidPublisher()

        init(barButtonItem: UIBarButtonItem) {
            super.init()

            self.barButtonItem = barButtonItem
            barButtonItem.target = self
            barButtonItem.action = #selector(actionHandler(_:))
        }

        @objc private func actionHandler(_ sender: AnyObject) {
            publisher.send(())
        }
    }
}

// MARK: - PublisherProxy (UIBarButtonItem)

extension PublisherProxy where Base: UIBarButtonItem {
    var tap: VoidPublisher {
        if let target = objc_getAssociatedObject(base, &AssociatedKeys.targetsKey) as? UIBarButtonItem.Target {
            return target.publisher
        }

        let target = UIBarButtonItem.Target(barButtonItem: base)
        objc_setAssociatedObject(base, &AssociatedKeys.targetsKey, target, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        return target.publisher
    }
}

// MARK: - PublisherKeyPathProxy (UIControl)

extension PublisherKeyPathProxy where Base: UIControl {
    var isEnabled: PublisherKeyPathValue<Base, Bool> { .init(base, keyPath: \.isEnabled) }
}

// MARK: - PublisherKeyPathProxy (UILabel)

extension PublisherKeyPathProxy where Base: UILabel {
    var text: PublisherKeyPathValue<Base, String?> { .init(base, keyPath: \.text) }
}

// MARK: - PublisherKeyPathProxy (UINavigationItem)

extension PublisherKeyPathProxy where Base: UINavigationItem {
    var title: PublisherKeyPathValue<Base, String?> { .init(base, keyPath: \.title) }
}
