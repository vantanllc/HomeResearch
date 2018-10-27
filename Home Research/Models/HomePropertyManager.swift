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
  
  static func deleteAllHomePropertyModels() {
    _ = try? Static.homePropertyModelStack.perform(
      synchronous: { (transaction) in
        transaction.deleteAll(From<HomePropertyModel>())
    }
    )
  }
  
  static func deleteHomeProperty(_ homeProperty: HomeProperty) {
    _ = try? Static.homePropertyModelStack.perform(
      synchronous: { (transaction) in
        let homePropertyModel = transaction.fetchOne(
          From<HomePropertyModel>()
            .where(\.sheriffNumber == Int32(homeProperty.sheriffNumber))
        )
        transaction.delete(homePropertyModel)
    }
    )
  }
  
  static func updateHomeProperty(_ homeProperty: HomeProperty) {
    _ = try? Static.homePropertyModelStack.perform(
      synchronous: { (transaction) in
        let homePropertyModel = transaction.fetchOne(
          From<HomePropertyModel>()
            .where(\.sheriffNumber == Int32(homeProperty.sheriffNumber))
        )
        
        homePropertyModel?.prices = homeProperty.getPricesAsData()
        homePropertyModel?.salesDate = homeProperty.salesDate
    }, waitForAllObservers: false
    )
  }
  
  static func writeNewHomeProperty(_ homeProperty: HomeProperty) {
    _ = try? Static.homePropertyModelStack.perform(
      synchronous: { (transaction) in
        let homePropertyModel = transaction.create(Into<HomePropertyModel>())
        homePropertyModel.sheriffNumber = Int32(homeProperty.sheriffNumber)
        homePropertyModel.judgementPrice = homeProperty.judgementPrice
        homePropertyModel.salesDate = homeProperty.salesDate
        homePropertyModel.address = homeProperty.address
        homePropertyModel.prices = homeProperty.getPricesAsData()
    }
    )
  }
}

class HomePropertyManager {
  private var homeProperties: Set<HomeProperty>
  
  init() {
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
  func getAllHomeProperty() -> [HomeProperty] {
    return Array(homeProperties)
  }
  
  func addNewHomeProperty(_ newHomeProperty: HomeProperty) {
    homeProperties.insert(newHomeProperty)
    Static.writeNewHomeProperty(newHomeProperty)
  }
  
  func deleteHomeProperty(_ homeProperty: HomeProperty) {
    homeProperties.remove(homeProperty)
    Static.deleteHomeProperty(homeProperty)
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
    Static.updateHomeProperty(updatedHomeProperty)
  }
}

