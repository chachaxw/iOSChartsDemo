//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class BarChartViewController: UIViewController {

    @IBOutlet weak var barView: BarChartView!
    
    @IBOutlet weak var textValue: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addBtnTapper(_ sender: Any) {
        if let value = textValue.text, value != "" {
            let visitorCount = VisitorCount()
            visitorCount.count = (NumberFormatter().number(from: value)?.intValue)!
            visitorCount.save()
            textValue.text = ""
        }

        updateChartWithData()
    }
    
    @IBAction func deleteBtn(_ sender: Any) {
        print(barView.data ?? "没有数据")
    }
    weak var axisFormatDelegate: IAxisValueFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        barView.noDataText = "There's no data in your chart"
        axisFormatDelegate = self
    }

    func updateChartWithData() {
        var dataEntries: [BarChartDataEntry] = []
        let visitorCounts = getVisitorCountsFromDataBase()
        
        for i in 0..<visitorCounts.count {
            let timeIntervalForDate: TimeInterval = visitorCounts[i].date.timeIntervalSince1970
            let dataEntry = BarChartDataEntry(x: timeIntervalForDate, y: Double(visitorCounts[i].count))
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Visitor Count")
        let chartData = BarChartData(dataSet: chartDataSet)
        barView.data = chartData
        
        let xaxis = barView.xAxis
        xaxis.valueFormatter = axisFormatDelegate
        
    }
    
    func getVisitorCountsFromDataBase() -> Results<VisitorCount> {
        do {
            let realm = try Realm()
            return realm.objects(VisitorCount.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }

}

// MARK: axisFormatDelegate
extension BarChartViewController: IAxisValueFormatter {
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:ss.mm"
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: value))
    }
}

















