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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(investiments: [Investiment]) {
        self.investiments = investiments
        updateChartData()
    }
    
    private lazy var pieChart: PieChartView = {
        let view = PieChartView()
        view.entryLabelFont = UIFont(name: "Avenir-Medium", size: 12)
        view.isUserInteractionEnabled = false
        view.legend.horizontalAlignment = .center
        return view
    }()
    
    private func updateChartData() {
        var dataEntry = [PieChartDataEntry]()
        var dataColors = [UIColor]()
        
        investiments.makeIterator().forEach { investiment in
            dataEntry.append(PieChartDataEntry(value: investiment.value, label: investiment.type.name))
            dataColors.append(investiment.type.color)
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntry, label: nil)
        chartDataSet.colors = dataColors

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
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
             view.heightAnchor.constraint(equalToConstant: 300)]
        }
    }
}
