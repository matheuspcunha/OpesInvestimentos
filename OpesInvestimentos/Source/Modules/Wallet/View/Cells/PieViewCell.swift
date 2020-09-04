//
//  PieViewCell.swift
//  OpesInvestimentos
//
//  Created by Matheus Cunha on 01/08/20.
//  Copyright © 2020 Matheus Cunha. All rights reserved.
//

import UIKit
import Charts

class PieViewCell: UICollectionViewCell {

    @IBOutlet weak var pieChart: PieChartView!

    private var dataEntry = [PieChartDataEntry]()

//    func configure(with viewModel: WalletViewModelPieItem) {
//        self.dataEntry = viewModel.dataEntry
//        updateChartData()
//    }

    private func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: dataEntry, label: nil)
        chartDataSet.colors = [.black]
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(DefaultValueFormatter(formatter: Formatter.percentFormatter))
        
        configurePieChart()
        pieChart.data = chartData
    }
    
    private func configurePieChart() {
        pieChart.entryLabelFont = UIFont(name: "Avenir-Medium", size: 12)
        pieChart.isUserInteractionEnabled = false
        pieChart.legend.horizontalAlignment = .center
        pieChart.rotationAngle = 125.0
    }
}
