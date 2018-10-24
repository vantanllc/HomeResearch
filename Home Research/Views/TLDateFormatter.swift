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
  }
  
  func getStringFromDate(_ date: Date?) -> String {
    guard let date = date else {
      return "NA"
    }
    
    dateFormatter.dateStyle = .long
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
  }
  
  func getShortStringFromDate(_ date: Date?) -> String {
    guard let date = date else {
      return "NA"
    }
    
    dateFormatter.dateStyle = .short
    dateFormatter.timeStyle = .none
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
  }
}
