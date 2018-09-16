//
//  HomePropertyTests.swift
//  Home ResearchTests
//
//  Created by Thinh Luong on 9/16/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Quick
import Nimble
@testable import Home_Research

class HomePropertySpec: QuickSpec {
  override func spec() {
    
    describe("HomeProperty Struct") {
      var homeProperty: HomeProperty!
      let expectedSheriffNumber = 123
      
      beforeEach {
        homeProperty = HomeProperty(sheriffNumber: expectedSheriffNumber)
      }
      
      it("should have expected sheriff number") {
        expect(homeProperty.sheriffNumber).to(equal(expectedSheriffNumber))
      }
    }
  }
}
