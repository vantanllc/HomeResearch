//
//  HomeProperty.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

struct HomeProperty: Hashable {
  var hashValue: Int {
    return sheriffNumber.hashValue
      ^ judgementPrice.hashValue
      ^ salesDate.hashValue
      ^ address.hashValue
  }
  
  static func == (lhs: HomeProperty, rhs: HomeProperty) -> Bool {
    return lhs.sheriffNumber == rhs.sheriffNumber
  }
  
  let sheriffNumber: Int
  let judgementPrice: Double
  let salesDate: Date
  let address: String
  let prices: [(date: Date, price: Double)]
}

extension HomeProperty {
  static func createRandomHomeProperty() -> HomeProperty {
    return HomeProperty(sheriffNumber: Int(arc4random()), judgementPrice: drand48() * 100000, salesDate: Date.init(), address: "1451 E Bell Ave, Des Moines, Iowa", prices: [])
  }
}
