import UIKit
import SnapKit


// MARK: PointsUIView

final class PointsUIView: UIView {

    // MARK: - Private Properties

    private lazy var tableView = UITableView().then {
        $0.dataSource = self
        $0.delegate = self
        $0.register(PointTableViewCell.self, forCellReuseIdentifier: "PointCell")
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: "ChartCell")
    }

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
}

// MARK: PointsUIView: UITableViewDataSource

extension PointsUIView: UITableViewDataSource {

    // MARK: - Internal Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return points.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case points.count - 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartTableViewCell
                cell.set(points: points, isSquiggly: isChartSquiggly)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "PointCell", for: indexPath) as! PointTableViewCell
                let point = points[indexPath.row]
                cell.textLabel?.text = "x: \(point.x) y: \(point.y)"
                cell.textLabel?.textColor = UIColor.subTitleColor
                return cell
        }
    }
}

// MARK: PointsUIView: UITableViewDelegate

extension PointsUIView: UITableViewDelegate {

    // MARK: - Internal Methods
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
            case points.count - 1:
                return 250
            default:
                return 44
        }
    }
}



