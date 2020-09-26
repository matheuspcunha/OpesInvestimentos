//
//  AssetsChartCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 23/09/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Charts

final class AssetsChartCell: UITableViewCell, Reusable {

    private var assets: [InvestimentAsset] = []
    private var totalInvestiment: Double = 0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(assets: [InvestimentAsset], totalInvestiment: Double) {
        self.assets = assets
        self.totalInvestiment = totalInvestiment
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
        assets.makeIterator().forEach { asset in
            dataEntry.append(PieChartDataEntry(value: asset.total / totalInvestiment,
                                               label: asset.symbol))
            dataColors.append(asset.color)
        }
        
        let chartDataSet = PieChartDataSet(entries: dataEntry, label: nil)
        chartDataSet.colors = dataColors
        chartDataSet.entryLabelColor = .clear
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(DefaultValueFormatter(formatter: Formatter.percentFormatter))
        pieChart.data = chartData
    }
}

extension AssetsChartCell: ViewCodeProtocol {

    func additionalSetup() {
        backgroundColor = .clear
    }
    
    func setupHierarchy() {
        addSubview(pieChart)
    }
    
    func setupConstraints() {
        pieChart.constraint { view in
            [view.topAnchor.constraint(equalTo: topAnchor),
             view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
             view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
             view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
             view.heightAnchor.constraint(equalToConstant: 400),]
        }
    }
}
