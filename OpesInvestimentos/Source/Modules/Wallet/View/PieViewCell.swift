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

    func configure(with viewModel: WalletViewModelPieItem) {
        self.dataEntry = viewModel.dataEntry
        updateChartData()
    }

    private func updateChartData() {
        let chartDataSet = PieChartDataSet(entries: dataEntry, label: nil)
        chartDataSet.colors = getColors()
        
        let chartData = PieChartData(dataSet: chartDataSet)
        chartData.setValueFormatter(DefaultValueFormatter(formatter: Formatter.percentFormatter))
        
        configurePieChart()
        pieChart.data = chartData
    }
    
    private func getColors() -> [UIColor] {
        var colors = [UIColor]()
        
        for data in dataEntry {
            if let label = data.label {
                switch label {
                case Type.Tesouro.rawValue:
                    colors.append(UIColor(red: 39/255.0, green: 174/255.0, blue: 96/255.0, alpha: 1.0))
                case Type.Fundos.rawValue:
                    colors.append(UIColor(red: 230/255.0, green: 126/255.0, blue: 34/255.0, alpha: 1.0))
                default:
                    colors.append(UIColor(red: 165/255.0, green: 94/255.0, blue: 234/255.0, alpha: 1.0))
                }
            }
        }
        
        return colors
    }
    
    private func configurePieChart() {
        pieChart.entryLabelFont = UIFont(name: "Avenir-Medium", size: 12)
        pieChart.isUserInteractionEnabled = false
        pieChart.legend.horizontalAlignment = .center
        pieChart.rotationAngle = 125.0
    }
}
