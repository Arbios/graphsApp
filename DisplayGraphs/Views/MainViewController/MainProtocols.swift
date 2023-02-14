import UIKit

// MARK: MainView

protocol MainView: AnyObject {
    func setButtonIsEnabled(_ isEnabled: Bool)
    func set(count: Int)
    func wiggleTextField()
}

extension MainView {}

// MARK: - MainPresenter

protocol MainPresenter: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func requestDotsClick(count: Int)
    func textDidChange(_ text: String?)
}

// MARK: - MainPresenterDelegate

protocol MainPresenterDelegate: AnyObject {
    func mainPresenterShowPointsScreein(_ presenter: MainPresenter, count: Int)
}
