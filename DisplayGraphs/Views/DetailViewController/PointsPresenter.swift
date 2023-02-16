import UIKit

// MARK: PointsPresenterDefault

final class PointsPresenterDefault {

    // MARK: - Internal Properties

    weak var delegate: PointsPresenterDelegate?

    @Dependency var api: APIService
    @Dependency var storage: StorageService

    // MARK: - Private Properties

    private weak var view: PointsView!
    private var count: Int
    private var points: [Point] = []

    // MARK: - Life Cycle

    init(view: PointsView, count: Int) {
        self.count = count
        self.view = view
    }
}

// MARK: PointsPresenterDefault (PointsPresenter)

extension PointsPresenterDefault: PointsPresenter {

    // MARK: - Internal Methods
    
    func viewDidLoad() {
        api.request(.fetchPoints(count)) { [weak self] (result: Result<PointsResponse, Error>) in
            switch result {
                case .success(let response):
                    // Preparing points
                    let sortedPoints = response.points.sorted { lhs, rhs in
                        lhs.x < rhs.x
                    }

                    self?.points = sortedPoints

                    DispatchQueue.main.async {
                        self?.view.set(points: sortedPoints)
                    }

                case .failure(let error):
                    let action = UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                        self?.viewDidLoad()
                    })
                    self?.view.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [action, .cancel])
            }
        }
    }

    func viewDidAppear() {}

    func toggleLineStyle() {
        view.toggleLineStyle()
    }

    func saveToFile() {
        storage.savePoints(points, with: "kotickFileName") { [weak self] result in
            guard let self = self else { return }

            switch result {
                case .success:
                    self.view.showAlert(title: "Успешно", message: "Данные успешно сохранены", actions: [.ok])
                case .failure(let error):
                    let action = UIAlertAction(title: "Повторить", style: .default, handler: { _ in
                        self.saveToFile()
                    })
                    self.view.showAlert(title: "Ошибка", message: error.localizedDescription, actions: [action, .cancel])
            }
        }
    }
}
