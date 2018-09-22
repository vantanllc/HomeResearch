//
//  AddNewHomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 9/22/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class AddNewHomePropertyTableViewController: UITableViewController {
  
  weak var delegate: HomePropertyTableViewDelegate?
  
  @IBOutlet weak var sheriffNumberTextField: UITextField!
  @IBOutlet weak var salesDatePicker: UIDatePicker!
  @IBOutlet weak var judgementPriceTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField! {
    didSet {
      return 
    }
  }
  
  @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveNewHomeProperty(_ sender: Any) {
    let newHomeProperty = HomeProperty(
      sheriffNumber: Int(sheriffNumberTextField.text!)!,
      judgementPrice: Double(judgementPriceTextField.text!)!,
      salesDate: salesDatePicker.date,
      address: addressTextField.text!)
    delegate?.didAddNewHomeProperty(newHomeProperty)
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}
