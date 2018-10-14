//
//  DetailedHomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class DetailedHomePropertyTableViewController: UITableViewController {
  var homeProperty: HomeProperty!
  
  @IBOutlet weak var sheriffNumberLabel: UILabel!
  @IBOutlet weak var salesDateLabel: UILabel!
  @IBOutlet weak var judgementPriceLabel: UILabel!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    sheriffNumberLabel.text = "\(homeProperty.sheriffNumber)"
    salesDateLabel.text = TLDateFormatter.shared.getStringFromDate(homeProperty.salesDate)
    judgementPriceLabel.text = CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: homeProperty.judgementPrice)
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
