//
//  HomeProperty.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

struct HomeProperty {
  let sheriffNumber: Int
  let judgementPrice: Double
  let salesDate: Date
  let address: String
  var prices: [(date: Date, price: Double)]
  
  mutating func addPrice(_ price: Double, onDate date: Date) {
    prices.append((date, price))
  }
  
  mutating func deletePrice(_ priceToDelete: Double, onDate date: Date) {
    prices = prices.filter {price in
      return !(price.date == date && price.price == priceToDelete)
    }
  }
  
  func getPricesToDisplay() -> [(date: Date, price: Double)] {
    return prices.reversed()
  }
}

extension HomeProperty {
  static func createRandomHomeProperty() -> HomeProperty {
    return HomeProperty(sheriffNumber: Int(arc4random()), judgementPrice: drand48() * 100000, salesDate: Date.init(), address: "1451 E Bell Ave, Des Moines, Iowa", prices: [(Date.init(timeIntervalSinceNow: 0),80000),(Date.init(timeIntervalSinceNow: 100000),100000)])
  }
}

extension HomeProperty: Hashable {
  var hashValue: Int {
    return sheriffNumber.hashValue
      ^ judgementPrice.hashValue
      ^ salesDate.hashValue
      ^ address.hashValue
  }
  
  static func == (lhs: HomeProperty, rhs: HomeProperty) -> Bool {
    return lhs.sheriffNumber == rhs.sheriffNumber
  }
}
