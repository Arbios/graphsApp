import UIKit
import SnapKit

// MARK: PointsViewCellDelegate

protocol PointsViewCellDelegate: AnyObject {
    func configure(pointCell: UITableViewCell, with point: Point)
    func configure(chartCell: UITableViewCell, with points: [Point], isSquiggly: Bool)
}

// MARK: PointsUIView

final class PointsUIView: UIView {

    // MARK: - Private Properties

    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(PointTableViewCell.self, forCellReuseIdentifier: pointCellReuseIdentifier)
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: chartCellReuseIdentifier)
    }
    private var chartCellReuseIdentifier = "ChartCell"
    private var pointCellReuseIdentifier = "PointCell"
    private var chartCellsCount = 1
    private var chartsRowHeight: CGFloat = 250
    private var defaultRowHeight: CGFloat = 44

    private var points: [Point] = []
    private var isChartSquiggly: Bool = false

    // MARK: - Life Cycle

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .backgroundColor

        setUpTableView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("not impelemted")
    }

    // MARK: - Internal Methods

    func set(points: [Point]) {
        self.points = points
        tableView.reloadData()
    }

    func toggleLineStyle() {
        isChartSquiggly.toggle()
        tableView.reloadRows(at: [IndexPath(row: points.count - 1, section: 0)], with: .automatic)
    }

    // MARK: - Private Methods

    private func setUpTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }

    private func configure(pointCell: UITableViewCell, with point: Point) {
        guard let cell = pointCell as? PointTableViewCell else { return }
        cell.textLabel?.text = "x: \(point.x) y: \(point.y)"
        cell.textLabel?.textColor = .subTitleColor
    }

    private func configure(chartCell: UITableViewCell, with points: [Point], isSquiggly: Bool) {
        guard let cell = chartCell as? ChartTableViewCell else { return }
        cell.set(points: points, isSquiggly: isSquiggly)
    }
}

// MARK: PointsUIView: UITableViewDataSource

extension PointsUIView: UITableViewDataSource {

    // MARK: - Internal Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count + chartCellsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case points.count:
                let cell = tableView.dequeueReusableCell(withIdentifier: chartCellReuseIdentifier, for: indexPath)
                configure(chartCell: cell, with: points, isSquiggly: isChartSquiggly)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: pointCellReuseIdentifier, for: indexPath)
                let point = points[indexPath.row]
                configure(pointCell: cell, with: point)
                return cell
        }
    }
}

// MARK: PointsUIView: UITableViewDelegate

extension PointsUIView: UITableViewDelegate {

    // MARK: - Internal Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case points.count:
                return chartsRowHeight
            default:
                return defaultRowHeight
        }
    }
}



