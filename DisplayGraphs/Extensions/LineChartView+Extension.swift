import Charts
import UIKit

// MARK: LineChartView

extension LineChartView {

    // MARK: - Internal Methods

    func setData(points: [Point], isSquiggly: Bool) {
        var chartDataEntries = [ChartDataEntry]()
        for i in 0..<points.count {
            let point = points[i]
            let dataEntry = ChartDataEntry(x: point.x, y: point.y)
            chartDataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: chartDataEntries, label: "")
        chartDataSet.drawCirclesEnabled = true
        chartDataSet.mode = isSquiggly ? .horizontalBezier : .linear
        chartDataSet.lineWidth = 3
        chartDataSet.valueColors = [UIColor.subTitleColor]
        chartDataSet.circleColors = [UIColor.accentColor]
        chartDataSet.circleHoleColor = UIColor.blueDotColor.withAlphaComponent(0.5)
        chartDataSet.colors = [UIColor.blueLineColor]
        chartDataSet.label = "Точки"

        chartDataSet.drawFilledEnabled = false

        let chartData = LineChartData(dataSet: chartDataSet)
        data = chartData
        animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
    }
}
