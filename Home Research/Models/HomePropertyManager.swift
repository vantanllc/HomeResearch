//
//  HomePropertyManager.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

class HomePropertyManager {
  private var homeProperties = Set<HomeProperty>()
  
  func addNewHomeProperty(_ newHomeProperty: HomeProperty) {
    homeProperties.insert(newHomeProperty)
  }
  
  func getHomePropertiesCount() -> Int {
    return homeProperties.count
  }
  
  func getHomePropertyAtIndex(_ index: Int) -> HomeProperty {
    let offsetIndex = homeProperties.index(homeProperties.startIndex, offsetBy: index)
    
    return homeProperties[offsetIndex]
  }
  
  func updateHomeProperty(_ updatedHomeProperty: HomeProperty) {
    homeProperties.update(with: updatedHomeProperty)
  }
}
