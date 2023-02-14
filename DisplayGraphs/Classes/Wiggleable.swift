import UIKit

// MARK: Wiggleable

protocol Wiggleable where Self: UIView {}

// MARK: Wiggleable

extension Wiggleable {

    // MARK: - Internal Methods

    func wiggle() {

        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")

        animation.duration = 1.0

        animation.fillMode = CAMediaTimingFillMode.both

        animation.values = [-0.05, 0, 0.05, 0, -0.025, 0, 0.025, 0, -0.0125, 0, 0.0125, 0, -0.00625, 0, 0.00625, 0, -0.003125, 0, 0.003125, 0]

        let group = CAAnimationGroup()
        group.animations = [animation]
        group.duration = 1.0
        group.repeatCount = 0
        group.isRemovedOnCompletion = false
        layer.add(group, forKey: "wiggle")
    }
}
