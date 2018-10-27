//
//  HomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit
import CoreStore

class HomePropertyTableViewController: UITableViewController {
  let homePropertyManager = HomePropertyManager()
  var selectedHomeProperty: HomeProperty?
  var detailedVC: MapOfAllHomePropertyViewController? {
    get {
      if let splitVC = self.splitViewController,
        let detailVC = splitVC.viewControllers[1] as? MapOfAllHomePropertyViewController {
        return detailVC
      } else {
        return nil
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    if let detailedVC = detailedVC {
      TLGeoCoder.shared.addHomeProperties(homePropertyManager.getAllHomeProperty(), toMapView: detailedVC.mapView)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homePropertyManager.getHomePropertiesCount()
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "HomePropertyCell", for: indexPath) as! HomePropertyTableViewCell
    
    let homeProperty = homePropertyManager.getHomePropertyAtIndex(indexPath.row)
    
    cell.sheriffNumberLabel.text = "\(homeProperty.sheriffNumber)"
    cell.salesDateLabel.text = TLDateFormatter.shared.getShortStringFromDate(homeProperty.salesDate)
    cell.addressLabel.text = "\(homeProperty.address)"
    cell.judgementPriceLabel.text = "\(CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice))"
    cell.resizeLabels()
    
    if homeProperty.salesDate > Date() {
      cell.backgroundColor = .green
    } else {
      cell.backgroundColor = .gray
    }
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    selectedHomeProperty = homePropertyManager.getHomePropertyAtIndex(indexPath.row)
    return indexPath
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let homePropertyToDelete = homePropertyManager.getHomePropertyAtIndex(indexPath.row)
      homePropertyManager.deleteHomeProperty(homePropertyToDelete)
      tableView.deleteRows(at: [indexPath], with: .automatic)
  
      TLGeoCoder.shared.deleteAnnotationForHomeProperty(homePropertyToDelete, inMapView: detailedVC?.mapView)
    }
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let addNewHomePropertyViewController = segue.destination as? AddNewHomePropertyTableViewController {
      addNewHomePropertyViewController.delegate = self
    }
    
    if let detailedHomePropertyViewController = segue.destination as? DetailedHomePropertyTableViewController {
      detailedHomePropertyViewController.homeProperty = selectedHomeProperty
      detailedHomePropertyViewController.delegate = self
    }
  }
}


