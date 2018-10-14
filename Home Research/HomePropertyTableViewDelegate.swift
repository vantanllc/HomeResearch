//
//  HomePropertyTableViewDelegate.swift
//  Home Research
//
//  Created by Thinh Luong on 9/22/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import Foundation

protocol HomePropertyTableViewDelegate: class {
  func didAddNewHomeProperty(_ homeProperty: HomeProperty)
}
