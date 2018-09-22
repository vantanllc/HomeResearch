//
//  CurrencyFormatter.swift
//  Home Research
//
//  Created by Thinh Luong on 9/22/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

class CurrencyFormatter {
  static let shared = CurrencyFormatter()
  private let numberFormatter = NumberFormatter()
  
  private init () {
    numberFormatter.groupingSeparator = ","
    numberFormatter.groupingSize = 3
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.decimalSeparator = "."
    numberFormatter.numberStyle = .decimal
    numberFormatter.maximumFractionDigits = 2
  }
  
  func convertPriceToCurrencyFormat(price: Double) -> String {
    return "$\(String(describing: numberFormatter.string(from: price as NSNumber)!))"
  }
}
