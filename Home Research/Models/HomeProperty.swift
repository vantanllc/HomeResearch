//
//  HomeProperty.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

struct HomeProperty {
  let sheriffNumber: UInt
  let judgementPrice: Double
  var salesDate: Date
  let address: String
  var prices: [PriceDate]
  
  mutating func addPrice(_ price: Double, onDate date: Date) {
    prices.append(PriceDate(date: date, price: price))
  }
  
  mutating func deletePrice(_ priceToDelete: Double?, onDate date: Date?) {
    prices = prices.filter {price in
      return !(price.date == date && price.price == priceToDelete)
    }
  }
  
  mutating func updateSalesDate(_ newSalesDate: Date) {
    salesDate = newSalesDate
  }
  
  func getPricesToDisplay() -> [PriceDate] {
    return prices.reversed()
  }
  
  func getPricesAsData() -> Data {
    return NSKeyedArchiver.archivedData(withRootObject: prices)
  }
}

extension HomeProperty {
  static func createRandomHomeProperty() -> HomeProperty {
    return HomeProperty(sheriffNumber: UInt(arc4random()), judgementPrice: drand48() * 100000, salesDate: Date.init(), address: "1451 E Bell Ave, Des Moines, Iowa", prices: [PriceDate(date: Date.init(timeIntervalSinceNow: 0), price: 80000),PriceDate(date: Date.init(timeIntervalSinceNow: 100000), price: 100000)])
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
