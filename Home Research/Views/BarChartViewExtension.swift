//
//  BarChartViewExtension.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Charts

extension BarChartView {
  
  private class BarChartFormatter: NSObject, IAxisValueFormatter {
    
    var labels: [String] = []
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
      return labels[Int(value)]
    }
    
    init(labels: [String]) {
      super.init()
      self.labels = labels
    }
  }
  
  func setBarChartData(xValues: [String], yValues: [Double], label: String) {
    
    var dataEntries: [BarChartDataEntry] = []
    
    for i in 0..<yValues.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
      dataEntries.append(dataEntry)
    }
    
    let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
    let chartData = BarChartData(dataSet: chartDataSet)
    
    let chartFormatter = BarChartFormatter(labels: xValues)
    let xAxis = XAxis()
    xAxis.valueFormatter = chartFormatter
    
    self.xAxis.valueFormatter = xAxis.valueFormatter
    
    self.data = chartData
  }
}
