//
//  PriceChartCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Charts

final class PriceChartCell: UITableViewCell, Reusable {

    private var prices: [Price] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(prices: [Price]) {
        self.prices = prices
        updateChartData()
    }
    
    private lazy var lineChart: LineChartView = {
        let view = LineChartView()
        view.backgroundColor = .clear
        view.rightAxis.enabled = false
        view.xAxis.labelPosition = .bottom
        view.xAxis.setLabelCount(6, force: false)
        view.fitScreen()
        view.animate(xAxisDuration: 1.5)
        view.delegate = self

        return view
    }()
    
    private func updateChartData() {
        var dataEntries = [ChartDataEntry]()
        var date = [String]()
        var values = [String]()
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        
        for i in 0..<prices.count{
            date.append(format.string(from: prices[i].date))
            values.append(String(prices[i].close).replacingOccurrences(of: ".", with: ","))
            dataEntries.append(ChartDataEntry(x: Double(i) , y: prices[i].close))
        }
        
        let dataSet = LineChartDataSet(entries: dataEntries, label: "Preço")
        dataSet.mode = .cubicBezier
        dataSet.drawCirclesEnabled = false
        dataSet.lineWidth = 1.5
        dataSet.setColor(.appBlue, alpha: 0.5)
        dataSet.fill = Fill.fillWithLinearGradient(self.gradientColors!, angle: 90.0)
        dataSet.drawFilledEnabled = true
        dataSet.drawHorizontalHighlightIndicatorEnabled = false
        dataSet.highlightColor = .darkGray
        dataSet.highlightEnabled = true
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: date)
        lineChart.leftAxis.valueFormatter = IndexAxisValueFormatter(values: values)

        lineChart.data = LineChartData(dataSet: dataSet)
    }
    
    private lazy var gradientColors: CGGradient? = {
        let gradientColors = [UIColor.appBlue.cgColor, UIColor.clear.cgColor] as CFArray
        return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                          colors: gradientColors,
                          locations: [1.0, 0.0])
    }()
}

extension PriceChartCell: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }

    func setupHierarchy() {
        addSubview(lineChart)
    }

    func setupConstraints() {
        lineChart.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor),
             view.trailingAnchor.constraint(equalTo: trailingAnchor),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 400)]
        }
    }
}

extension PriceChartCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        lineChart.highlightValues([highlight])
    }
}
