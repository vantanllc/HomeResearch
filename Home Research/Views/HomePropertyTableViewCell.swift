//
//  HomePropertyTableViewCell.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class HomePropertyTableViewCell: UITableViewCell {
  @IBOutlet weak var sheriffNumberLabel: UILabel!
  @IBOutlet weak var salesDateLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var judgementPriceLabel: UILabel!
  
  func resizeLabels() {
    sheriffNumberLabel.sizeToFit()
    salesDateLabel.sizeToFit()
    addressLabel.sizeToFit()
    judgementPriceLabel.sizeToFit()
  }
}
