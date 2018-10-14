//
//  DetailedHomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit
import Mapbox
import Charts

class DetailedHomePropertyTableViewController: UITableViewController {
  var homeProperty: HomeProperty!
  
  @IBOutlet weak var sheriffNumberLabel: UILabel!
  @IBOutlet weak var salesDateLabel: UILabel!
  @IBOutlet weak var judgementPriceLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var mapView: MGLMapView!
  @IBOutlet weak var barChartView: BarChartView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sheriffNumberLabel.text = "\(homeProperty.sheriffNumber)"
    salesDateLabel.text = TLDateFormatter.shared.getStringFromDate(homeProperty.salesDate)
    judgementPriceLabel.text = CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice)
    addressLabel.text = homeProperty.address
    
//    var dataEntries: [BarChartDataEntry] = []
//    for index in 0..<homeProperty.prices.count {
//      let priceData = BarChartDataEntry(x: Double(index), y: homeProperty.prices[index].price)
//      dataEntries.append(priceData)
//    }
//
//    let chartDataSet = BarChartDataSet(values: dataEntries, label: "$")
//    let chartData = BarChartData()
//    chartData.addDataSet(chartDataSet)
//    barChartView.data = chartData
    let xValues = homeProperty.prices.map {TLDateFormatter.shared.getShortStringFromDate($0.date)}
    let yValues = homeProperty.prices.map {$0.price}

    barChartView.autoScaleMinMaxEnabled = false
    barChartView.setBarChartData(xValues: xValues, yValues: yValues, label: "$")
    barChartView.leftAxis.axisMinimum = 0.0
    barChartView.leftAxis.axisMaximum = 200000
    barChartView.rightAxis.enabled = false
    
    
    TLGeoCoder.shared.geocodeAddressString(homeProperty.address) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
        else {
          return
      }
      
      TLGeoCoder.shared.addMapAnnotation(withAddress: self.homeProperty.address, atCoordinate: location.coordinate, toMapView: self.mapView)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
