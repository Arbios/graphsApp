import UIKit

// MARK: PointsVC

final class PointsVC: BaseViewController<PointsUIView> {

    // MARK: - Internal Properties

    var presenter: PointsPresenter!

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let saveBarButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        saveBarButton.setImage(UIImage.saveIcon.withRenderingMode(.alwaysTemplate), for: [])
        saveBarButton.addTarget(self, action: #selector(saveBarButtonItemClick(_:)), for: .touchUpInside)
        saveBarButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        saveBarButton.tintColor = .blueLineColor
        let saveBarButtonItem = UIBarButtonItem(customView: saveBarButton)

        let lineTypeButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        lineTypeButton.setImage(UIImage.squigglyLineIcon.withRenderingMode(.alwaysTemplate), for: [])
        lineTypeButton.addTarget(self, action: #selector(toggleLineStyleBarButtonItemClick(_:)), for: .touchUpInside)
        lineTypeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        lineTypeButton.tintColor = .blueLineColor
        let lineTypeButtonItem = UIBarButtonItem(customView: lineTypeButton)

        navigationItem.rightBarButtonItems = [saveBarButtonItem, lineTypeButtonItem]

        navigationItem.title = "Точки"

        presenter.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    // MARK: - Actions

    @objc private func saveBarButtonItemClick(_ sender: UIBarButtonItem) {
        presenter.saveToFile()
    }

    @objc private func toggleLineStyleBarButtonItemClick(_ sender: UIBarButtonItem) {
        presenter.toggleLineStyle()
    }
}

// MARK: - PointsVC (PointsView)

extension PointsVC: PointsView {

    // MARK: - Internal Methods

    func set(points: [Point]) {
        rootView.set(points: points)
    }

    func toggleLineStyle() {
        rootView.toggleLineStyle()
    }

    func showAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            alert.addAction(action)
        }

        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}
