import UIKit

// MARK: MainVC

final class MainVC: BaseViewController<MainUIView> {

    // MARK: - Internal Properties

    var presenter: MainPresenter!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        rootView.onRequestDotsTap = { [unowned self] count in
            self.presenter.requestDotsClick(count: count)
        }

        rootView.onTextChange = { [unowned self] text in
            self.presenter.textDidChange(text)
        }
        presenter.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }
}

// MARK: - MainVC (MainView)

extension MainVC: MainView {
    func set(count: Int) {
        rootView.set(count: count)
    }

    func setButtonIsEnabled(_ isEnabled: Bool) {
        rootView.setButtonIsEnabled(isEnabled)
    }

    func wiggleTextField() {
        rootView.wiggleTextField()
    }
}
