//
//  PriceChartCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 26/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Charts

enum ChartPeriod {
    case oneMonth, threeMonth, week, all
    
    func filter(prices: [Price]) -> [Price] {
        var pricesFiltered: [Price] = []
        let current = prices.reduce(prices[0], { $0.date > $1.date ? $0 : $1 }).date
        
        switch self {
        case .week:
            if let week = current.getLast7Days() {
                pricesFiltered = prices.filter({$0.date > week})
            }
        case .oneMonth:
            if let oneMonth = current.getLast30Days() {
                pricesFiltered = prices.filter({$0.date > oneMonth})
            }
        case .threeMonth:
            if let threeMonth = current.getLast3Month() {
                pricesFiltered = prices.filter({$0.date > threeMonth})
            }
        case .all:
            pricesFiltered = prices
        }
        
        return pricesFiltered.sorted(by: {$0.date > $1.date})
    }
}

final class PricesChartView: UIView {

    init() {
        super.init(frame: .zero)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var lineChart: LineChartView = {
        let view = LineChartView(frame: .zero)
        view.backgroundColor = .clear
        view.rightAxis.enabled = false
        view.xAxis.labelPosition = .bottom
        view.xAxis.setLabelCount(7, force: false)
        view.delegate = self
        return view
    }()
    
    private lazy var gradientColors: CGGradient? = {
        let gradientColors = [UIColor.appBlue.cgColor, UIColor.clear.cgColor] as CFArray
        return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                          colors: gradientColors,
                          locations: [1.0, 0.0])
    }()
    
    public func updateData(prices: [Price], period: ChartPeriod = .week) {
        var dataEntries = [ChartDataEntry]()
        var date = [String]()
        var values = [String]()
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        
        let data = period.filter(prices: prices)
        for i in 0..<data.count{
            date.append(format.string(from: data[i].date))
            values.append(String(data[i].close).replacingOccurrences(of: ".", with: ","))
            dataEntries.append(ChartDataEntry(x: Double(i) , y: data[i].close))
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
        lineChart.animate(xAxisDuration: 1.5)
        lineChart.data = LineChartData(dataSet: dataSet)
    }
}

extension PricesChartView: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }

    func setupHierarchy() {
        addSubview(lineChart)
    }

    func setupConstraints() {
        lineChart.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 400)]
        }
    }
}

extension PricesChartView: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        lineChart.highlightValues([highlight])
    }
}
