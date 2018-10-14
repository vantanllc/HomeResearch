//
//  TLDateFormatter.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

class TLDateFormatter {
  static let shared = TLDateFormatter()
  private let dateFormatter = DateFormatter()
  
  private init() {
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "en_US")
  }
  
  func getStringFromDate(_ date: Date) -> String {
    return dateFormatter.string(from: date)
  }
}
