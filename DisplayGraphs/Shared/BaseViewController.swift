import UIKit

// MARK: BaseViewController

class BaseViewController<ViewClass: UIView>: UIViewController {

    // MARK: Internal Properties

    var rootView: ViewClass { view as! ViewClass }

    override var preferredStatusBarStyle: UIStatusBarStyle { .default }

    // MARK: - Lifecycle

    override func loadView() {
        view = ViewClass(frame: CGRect.zero)
    }
}
