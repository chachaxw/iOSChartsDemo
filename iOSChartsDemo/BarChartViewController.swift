//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        barView.noDataText = "There's no data in your chart"
        
        updateChartWithData()
    }

    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
//        let visitorCounts = getVisitorCountsFromDataBase()
        let visitorCounts = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        for i in 0..<visitorCounts.count {
//            let timeIntervalForDate: TimeInterval = visitorCounts[i].date.timeIntervalSince1970
            let dataEntry = BarChartDataEntry(x: Double(visitorCounts[i]), y: Double(i))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor Count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        
        let xaxis = barView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        
    }
    
    func getVisitorCountsFromDataBase() {
        
    }

}

// MARK: axisFormatDelegate
//extension ViewController: IAxisValueFormatter {
//    
//}

















