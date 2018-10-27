//
//  EditSalesDateTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/27/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class EditSalesDateTableViewController: UITableViewController {
  
  weak var delegate: EditSalesDateDelegate?
  var currentSalesDateToDisplay: Date?
  
  @IBAction func saveNewSalesDate(_ sender: UIBarButtonItem) {
    delegate?.didEditSalesDate(newSalesDatePicker.date)
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func cancelNewSalesDate(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var currentSalesdate: UILabel!
  @IBOutlet weak var newSalesDatePicker: UIDatePicker!
  override func viewDidLoad() {
    super.viewDidLoad()
    currentSalesdate.text = TLDateFormatter.shared.getShortStringFromDate(currentSalesDateToDisplay)
  }
  
}
