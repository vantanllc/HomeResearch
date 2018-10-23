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
    
    _ = try? dataStack.perform(
      synchronous: { (transaction) in
        
        transaction.deleteAll(From<HomePropertyModel>())
        
        let account1 = transaction.create(Into<HomePropertyModel>())
        account1.sheriffNumber = 123456
        account1.judgementPrice = 123.34
        account1.salesDate = Date.init(timeIntervalSinceNow: 10)
        account1.address = "1451 E Bell Ave Des Moines, Iowa 50320"
        let priceDate = PriceDate(date: Date.init(timeIntervalSinceNow: 0), price: 80000.00)
        let data = NSKeyedArchiver.archivedData(withRootObject: [
            priceDate
          ]
        )
        account1.prices = data
    }
    )
    return dataStack
  }()
}

class HomePropertyManager {
  private var homeProperties: Set<HomeProperty>
  
  init() {
    let homePropertyModels = Static.homePropertyModelStack.fetchAll(From(HomePropertyModel.self)) ?? []
    
    homeProperties = Set(homePropertyModels.compactMap {model in
      let sheriffNumber = Int(model.sheriffNumber)
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
        prices: [(priceDates[0].date!, priceDates[0].price!)]
      )
      return homeProperty
    })
  }
  
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

