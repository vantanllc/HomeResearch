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
  weak var delegate: DetailedHomePropertyDelegate?
  
  @IBOutlet weak var sheriffNumberLabel: UILabel!
  @IBOutlet weak var salesDateLabel: UILabel!
  @IBOutlet weak var judgementPriceLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var mapView: MGLMapView!
  @IBOutlet weak var barChartView: BarChartView!
  
  var tapBGGesture: UITapGestureRecognizer!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sheriffNumberLabel.text = "\(homeProperty.sheriffNumber)"
    salesDateLabel.text = TLDateFormatter.shared.getStringFromDate(homeProperty.salesDate)
    judgementPriceLabel.text = CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice)
    addressLabel.text = homeProperty.address
    
    loadBarChart()
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
  
  override func viewDidAppear(_ animated: Bool) {
    tapBGGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(sender:)))
    tapBGGesture.delegate = self
    tapBGGesture.numberOfTapsRequired = 1
    tapBGGesture.cancelsTouchesInView = false
    self.view.window!.addGestureRecognizer(tapBGGesture)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    self.view.window!.removeGestureRecognizer(tapBGGesture)
  }
  
  func loadBarChart() {
    let xValues = homeProperty.prices.compactMap {TLDateFormatter.shared.getShortStringFromDate($0.date)}
    let yValues = homeProperty.prices.compactMap {$0.price}
    
    barChartView.autoScaleMinMaxEnabled = false
    barChartView.setBarChartData(xValues: xValues, yValues: yValues, label: "$")
    barChartView.leftAxis.axisMinimum = 0.0
    barChartView.leftAxis.axisMaximum = 200000
    barChartView.rightAxis.enabled = false
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let priceHistoryViewController = segue.destination as? PriceHistoryTableViewController {
      priceHistoryViewController.homeProperty = homeProperty
      priceHistoryViewController.delegate = self
    }
    if let addNewPriceViewController = segue.destination as? AddNewPriceTableViewController {
      addNewPriceViewController.delegate = self
    }
  }
}

extension DetailedHomePropertyTableViewController: UIGestureRecognizerDelegate {
  @objc private func onTap(sender: UITapGestureRecognizer) {
    self.view.window?.removeGestureRecognizer(sender)
    self.dismiss(animated: true, completion: nil)
  }
  
  internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    let location = touch.location(in: self.view)
    
    if self.view.point(inside: location, with: nil) {
      return false
    }
    else {
      return true
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

extension DetailedHomePropertyTableViewController: AddNewPriceDelegate {
  func didAddNewPrice(_ newPrice: Double, atDate date: Date) {
    homeProperty.addPrice(newPrice, onDate: date)
    loadBarChart()
    delegate?.didUpdateHomeProperty(homeProperty)
  }
}

extension DetailedHomePropertyTableViewController: PriceHistoryDelegate {
  func didUpdateHomeProperty(_ updatedHomeProperty: HomeProperty) {
    homeProperty = updatedHomeProperty
    loadBarChart()
    delegate?.didUpdateHomeProperty(updatedHomeProperty)
  }
}
