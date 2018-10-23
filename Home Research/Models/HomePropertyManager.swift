//
//  HomePropertyManager.swift
//  Home Research
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation
import CoreStore

private struct Static {
  
  static let homePropertyModelConfiguration = "Default"
  
  static let homePropertyModelStack: DataStack = {
    
    let dataStack = DataStack(xcodeModelName: "Home_Research")
    try! dataStack.addStorageAndWait(
      SQLiteStore(
        fileName: "HomeResearchHomePropertyModel.sqlite",
        configuration: homePropertyModelConfiguration,
        localStorageOptions: .recreateStoreOnModelMismatch
      )
    )
    
    return dataStack
  }()
  
  static func writeNewHomeProperty(_ homeProperty: HomeProperty) {
    _ = try? Static.homePropertyModelStack.perform(
      synchronous: { (transaction) in
        
        transaction.deleteAll(From<HomePropertyModel>())
        
        let homePropertyModel = transaction.create(Into<HomePropertyModel>())
        homePropertyModel.sheriffNumber = Int32(homeProperty.sheriffNumber)
        homePropertyModel.judgementPrice = homeProperty.judgementPrice
        homePropertyModel.salesDate = homeProperty.salesDate
        homePropertyModel.address = homeProperty.address
        homePropertyModel.prices = NSKeyedArchiver.archivedData(withRootObject: homeProperty.prices)
    }
    )
  }
}

class HomePropertyManager {
  private var homeProperties: Set<HomeProperty>
  
  init() {
    Static.writeNewHomeProperty(HomeProperty.createRandomHomeProperty())
    
    let homePropertyModels = Static.homePropertyModelStack.fetchAll(From(HomePropertyModel.self)) ?? []
    
    homeProperties = Set(homePropertyModels.compactMap {model in
      let sheriffNumber = UInt(model.sheriffNumber)
      let judgementPrice = model.judgementPrice
      guard let salesDate = model.salesDate,
            let address = model.address,
            let prices = model.prices,
            let priceDates = NSKeyedUnarchiver.unarchiveObject(with: prices) as? [PriceDate]
      else {
        return nil
      }
      
      let homeProperty = HomeProperty(
        sheriffNumber: sheriffNumber,
        judgementPrice: judgementPrice,
        salesDate: salesDate,
        address: address,
        prices: priceDates
      )
      return homeProperty
    })
  }
}

extension HomePropertyManager {
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

