//
//  HomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class HomePropertyTableViewController: UITableViewController {
  let homePropertyManager = HomePropertyManager()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    homePropertyManager.addNewHomeProperty(HomeProperty.createRandomHomeProperty())
    homePropertyManager.addNewHomeProperty(HomeProperty.createRandomHomeProperty())
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
    cell.salesDateLabel.text = "\(homeProperty.salesDate)"
    cell.addressLabel.text = "\(homeProperty.address)"
    cell.judgementPriceLabel.text = "\(CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice))"
    cell.resizeLabels()
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let addNewHomePropertyViewController = segue.destination as? AddNewHomePropertyTableViewController else {
      return
    }
    
    addNewHomePropertyViewController.delegate = self
  }
}



