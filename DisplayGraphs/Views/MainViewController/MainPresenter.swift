import UIKit

// MARK: MainPresenterDefault

final class MainPresenterDefault {

    // MARK: - Internal Properties

    weak var delegate: MainPresenterDelegate?

    // MARK: - Private Properties

    private weak var view: MainView!

    // MARK: - Life Cycle

    init(view: MainView) {
        self.view = view
    }
}

// MARK: MainPresenterDefault (MainPresenter)

extension MainPresenterDefault: MainPresenter {

    // MARK: - Internal Methods

    func viewDidLoad() {
        view.setButtonIsEnabled(false)
    }

    func viewDidAppear() {}

    func requestDotsClick(count: Int) {
        if count == 0 {
            view.wiggleTextField()
        } else {
            delegate?.mainPresenterShowPointsScreein(self, count: count)
        }
    }

    func textDidChange(_ text: String?) {
        guard let text = text else { return }

        guard let count = Int(text) else { return }

        view.set(count: count)
        view.setButtonIsEnabled(count != 0)
    }
}
