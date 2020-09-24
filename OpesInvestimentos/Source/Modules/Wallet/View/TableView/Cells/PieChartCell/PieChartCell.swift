//
//  PieChartCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Charts

final class PieChartCell: UITableViewCell, Reusable {

    private var investiments: [Investiment] = []
    private var totalWallet: Double = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(investiments: [Investiment], totalWallet: Double) {
        self.investiments = investiments
        self.totalWallet = totalWallet
        updateChartData()
    }
    
    private lazy var pieChart: PieChartView = {
        let view = PieChartView()
        view.entryLabelFont = UIFont(name: "Avenir-Medium", size: 12)
        view.isUserInteractionEnabled = false
        view.legend.horizontalAlignment = .center
        view.rotationAngle = 125.0
        return view
    }()
    
    private func updateChartData() {
        var dataEntry = [PieChartDataEntry]()
        var dataColors = [UIColor]()
        investiments.makeIterator().forEach { investiment in
            dataEntry.append(PieChartDataEntry(value: investiment.total / totalWallet,
                                               label: investiment.type.name))
            dataColors.append(investiment.type.color)
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntry, label: nil)
        chartDataSet.colors = dataColors
//        chartDataSet.xValuePosition = .outsideSlice
//        chartDataSet.yValuePosition = .outsideSlice
//        chartDataSet.valueTextColor = .darkGray
//        chartDataSet.entryLabelColor = .darkGray
//        chartDataSet.valueLineWidth = 0.1
//        chartDataSet.valueLinePart1Length = 0.2
//        chartDataSet.valueLinePart2Length = 1

        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(DefaultValueFormatter(formatter: Formatter.percentFormatter))
        pieChart.data = chartData
    }
}

extension PieChartCell: ViewCodeProtocol {
    
    func setupHierarchy() {
        addSubview(pieChart)
    }
    
    func setupConstraints() {
        pieChart.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
             view.heightAnchor.constraint(equalToConstant: 300),]
        }
    }
}
