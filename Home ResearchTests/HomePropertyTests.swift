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
      let expectedJudgementPrice = 22.09
      let futureTime: TimeInterval = 450
      let expectedSalesDate = Date.init(timeIntervalSinceNow: futureTime)
      let expectedAddress = "1283 Grand Ave NY City NY 55500"
      
      beforeEach {
        homeProperty = HomeProperty(sheriffNumber: expectedSheriffNumber, judgementPrice: expectedJudgementPrice, salesDate: expectedSalesDate, address: expectedAddress)
      }
      
      it("should have expected Home Property attributes.") {
        expect(homeProperty.sheriffNumber).to(equal(expectedSheriffNumber))
        expect(homeProperty.judgementPrice).to(equal(expectedJudgementPrice))
        expect(homeProperty.salesDate).to(equal(expectedSalesDate))
        expect(homeProperty.address).to(equal(expectedAddress))
      }
    }
  }
}
