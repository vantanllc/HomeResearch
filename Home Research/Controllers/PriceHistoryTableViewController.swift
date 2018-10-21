//
//  AddPriceTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/21/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class PriceHistoryTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
  var homeProperty: HomeProperty!
  weak var delegate: PriceHistoryDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Table view data source
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeProperty.getPricesToDisplay().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddPriceCell", for: indexPath)
    
    let date = homeProperty.getPricesToDisplay()[indexPath.row].date
    let price = homeProperty.getPricesToDisplay()[indexPath.row].price
    
    cell.textLabel?.text = TLDateFormatter.shared.getShortStringFromDate(date)
    cell.detailTextLabel?.text = CurrencyFormatter.shared.convertPriceToCurrencyFormat(price: price)
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let addNewPriceViewController = segue.destination as? AddNewPriceTableViewController {
      addNewPriceViewController.delegate = self
    }
  }
}

extension PriceHistoryTableViewController: AddNewPriceDelegate {
  func didAddNewPrice(_ newPrice: Double, atDate date: Date) {
    homeProperty.addPrice(newPrice, onDate: date)
    tableView.reloadData()
    delegate?.didUpdateHomeProperty(homeProperty)
  }
}
