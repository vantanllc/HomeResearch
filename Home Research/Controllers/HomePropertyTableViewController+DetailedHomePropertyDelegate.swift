//
//  HomePropertyTableViewController+DetailedHomePropertyDelegate.swift
//  Home Research
//
//  Created by Thinh Luong on 10/21/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

extension HomePropertyTableViewController: DetailedHomePropertyDelegate {
  func didUpdateHomeProperty(_ updatedHomeProperty: HomeProperty) {
    homePropertyManager.updateHomeProperty(updatedHomeProperty)
    tableView.reloadData()
  }
}
