//
//  HomePropertyManager.swift
//  Home ResearchTests
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Quick
import Nimble
@testable import Home_Research

class HomePropertyManagerSpec: QuickSpec {
  override func spec() {
    var homePropertyManager: HomePropertyManager!
    
    describe("HomePropertyManager") {
      beforeEach {
        homePropertyManager = HomePropertyManager()
      }
      
      it("should insert a new home property") {
        let newHomeProperty = HomeProperty.createRandomHomeProperty()
        
        expect(homePropertyManager.getHomePropertiesCount()).to(equal(0))
        
        homePropertyManager.addNewHomeProperty(newHomeProperty)
        
        expect(homePropertyManager.getHomePropertiesCount()).to(equal(1))
      }
    }
  }
}
