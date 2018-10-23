//
//  PriceDate.swift
//  Home Research
//
//  Created by Thinh Luong on 10/23/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

class PriceDate: NSObject {
  var date: Date?
  var price: Double?
  
  init(date: Date?, price: Double?) {
    self.date = date
    self.price = price
  }
  
  required convenience init?(coder decoder: NSCoder) {
    guard let date = decoder.decodeObject(forKey: "date") as? Date,
      let price = decoder.decodeObject(forKey: "price") as? Double else { return nil }
    
    self.init(date: date, price: price)
  }
}

extension PriceDate: NSCoding {
  func encode(with aCoder: NSCoder) {
    aCoder.encode(self.date, forKey: "date")
    aCoder.encode(self.price, forKey: "price")
  }
}
