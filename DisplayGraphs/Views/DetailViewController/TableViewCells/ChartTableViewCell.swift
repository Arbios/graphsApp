import Charts
import UIKit

// MARK: ChartTableViewCell

class ChartTableViewCell: UITableViewCell {

    // MARK: - Internal Properties

    let chartView = LineChartView().then {
        $0.drawGridBackgroundEnabled = false
        $0.drawBordersEnabled = false
        $0.xAxis.drawAxisLineEnabled = false
        $0.xAxis.drawGridLinesEnabled = false
        $0.rightAxis.drawGridLinesEnabled = false
        $0.leftAxis.drawGridLinesEnabled = false
        $0.leftAxis.drawAxisLineEnabled = false
        $0.rightAxis.drawAxisLineEnabled = false
        $0.rightAxis.drawLabelsEnabled = false
        $0.xAxis.drawLabelsEnabled = false
        $0.leftAxis.labelTextColor = #colorLiteral(red: 0.5529411765, green: 0.5529411765, blue: 0.5529411765, alpha: 1)
    }

    // MARK: - Private Properties

    private var points: [Point] = []

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Internal Methods

    func set(points: [Point], isSquiggly: Bool) {
        setUpChartView()
        self.points = points
        chartView.setData(points: points, isSquiggly: isSquiggly)
    }

    // MARK: - Private Methods

    private func setUpChartView() {
        addSubview(chartView)
        chartView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
