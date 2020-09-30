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
    case oneMonth, threeMonth, sixMonth, all
    
    func filter(prices: [Price]) -> [Price] {
        var pricesFiltered: [Price] = []
        
        switch self {
        case .oneMonth:
            if let oneMonth = Date().getLast30Day() {
                pricesFiltered = prices.filter({$0.date < oneMonth})
            }
        case .threeMonth:
            if let threeMonth = Date().getLast3Month() {
                pricesFiltered = prices.filter({$0.date < threeMonth})
            }
        case .sixMonth:
            if let sixMonth = Date().getLast6Month() {
                pricesFiltered = prices.filter({$0.date < sixMonth})
            }
        default:
            pricesFiltered = prices
        }
        
        return pricesFiltered
    }
}

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
    
    private lazy var gradientColors: CGGradient? = {
        let gradientColors = [UIColor.appBlue.cgColor, UIColor.clear.cgColor] as CFArray
        return CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                          colors: gradientColors,
                          locations: [1.0, 0.0])
    }()
    
    private lazy var oneMonthButton: UIButton = {
        let button = UIButton(style: .secondary, text: "1M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var threeMonthButton: UIButton = {
        let button = UIButton(style: .secondary, text: "3M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var sixMonthButton: UIButton = {
        let button = UIButton(style: .secondary, text: "6M")
        button.addTarget(self, action: #selector(didPressButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didPressButton(sender: UIButton) {
        switch(sender){
        case oneMonthButton:
            updateChartData(period: .oneMonth)
        case threeMonthButton:
            updateChartData(period: .threeMonth)
        case sixMonthButton:
            updateChartData(period: .sixMonth)
        default:
            break
        }
    }

    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 20
        return stack
    }()
    
    private func updateChartData(period: ChartPeriod = .all) {
        var dataEntries = [ChartDataEntry]()
        var date = [String]()
        var values = [String]()
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM"
        
        let data = period.filter(prices: self.prices)
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

        lineChart.data = LineChartData(dataSet: dataSet)
    }
}

extension PriceChartCell: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }

    func setupHierarchy() {
        buttonsStack.addArrangedSubview(oneMonthButton)
        buttonsStack.addArrangedSubview(threeMonthButton)
        buttonsStack.addArrangedSubview(sixMonthButton)

        addSubview(lineChart)
        addSubview(buttonsStack)
    }

    func setupConstraints() {
        lineChart.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
             view.heightAnchor.constraint(equalToConstant: 400)]
        }
        
        buttonsStack.constraint { view in
            [view.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 20),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40)]
        }
    }
}

extension PriceChartCell: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        lineChart.highlightValues([highlight])
    }
}
