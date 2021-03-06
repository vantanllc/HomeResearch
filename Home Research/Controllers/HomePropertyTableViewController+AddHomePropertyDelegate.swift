//
//  HomePropertyTableViewController+HomePropertyTableViewDelegate.swift
//  Home Research
//
//  Created by Thinh Luong on 9/22/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

extension HomePropertyTableViewController: AddHomePropertyDelegate {
  func didAddNewHomeProperty(_ homeProperty: HomeProperty) {
    homePropertyManager.addNewHomeProperty(homeProperty)
    if let detailedVC = detailedVC {
      TLGeoCoder.shared.addHomeProperty(homeProperty, toMapView: detailedVC.mapView)
    }
    
    tableView.reloadData()
  }
}
