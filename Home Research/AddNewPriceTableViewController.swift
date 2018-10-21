//
//  AddNewPriceTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/21/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class AddNewPriceTableViewController: UITableViewController {
  
  weak var delegate: PriceHistoryDelegate?
  
  @IBAction func cancelAddingNewPrice(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveNewPrice(_ sender: UIBarButtonItem) {
    guard let price = newPriceTextField.text else {
      return
    }
    
    delegate?.didAddNewPrice(Double(price)!, atDate: datePicker.date)
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var newPriceTextField: UITextField!
  
  @IBOutlet weak var datePicker: UIDatePicker!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
}
