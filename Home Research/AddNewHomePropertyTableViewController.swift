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
  @IBOutlet weak var addressTextField: UITextField!
  
  @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func saveNewHomeProperty(_ sender: Any) {
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  
}
