//
//  PriceHistoryDelegate.swift
//  Home Research
//
//  Created by Thinh Luong on 10/21/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

protocol PriceHistoryDelegate: class {
  func didUpdateHomeProperty(_ updatedHomeProperty: HomeProperty)
}
