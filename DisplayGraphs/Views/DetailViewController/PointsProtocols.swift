import UIKit

// MARK: PointsView

protocol PointsView: AnyObject {
    func set(points: [Point])
    func toggleLineStyle()
    func showAlert(title: String, message: String, actions: [UIAlertAction])
}

// MARK: - PointsPresenter

protocol PointsPresenter: AnyObject {
    func viewDidLoad()
    func viewDidAppear()
    func toggleLineStyle()
    func saveToFile()
}

// MARK: - PointsPresenterDelegate

protocol PointsPresenterDelegate: AnyObject {
}
