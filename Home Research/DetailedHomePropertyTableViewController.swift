//
//  DetailedHomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit
import Mapbox

class DetailedHomePropertyTableViewController: UITableViewController {
  var homeProperty: HomeProperty!
  
  @IBOutlet weak var sheriffNumberLabel: UILabel!
  @IBOutlet weak var salesDateLabel: UILabel!
  @IBOutlet weak var judgementPriceLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var mapView: MGLMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sheriffNumberLabel.text = "\(homeProperty.sheriffNumber)"
    salesDateLabel.text = TLDateFormatter.shared.getStringFromDate(homeProperty.salesDate)
    judgementPriceLabel.text = CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice)
    addressLabel.text = homeProperty.address
    
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
