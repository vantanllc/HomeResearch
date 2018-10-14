//
//  HomeProperty.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

struct HomeProperty: Hashable {
  let sheriffNumber: Int
  let judgementPrice: Double
  let salesDate: Date
  let address: String
}

extension HomeProperty {
  static func createRandomHomeProperty() -> HomeProperty {
    return HomeProperty(sheriffNumber: Int(arc4random()), judgementPrice: drand48() * 100000, salesDate: Date.init(), address: "Some Address")
  }
}
