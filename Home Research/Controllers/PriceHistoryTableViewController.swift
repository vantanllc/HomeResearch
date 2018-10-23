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
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let prices = homeProperty.getPricesToDisplay()
      homeProperty.deletePrice(prices[indexPath.row].price, onDate: prices[indexPath.row].date)
      tableView.deleteRows(at: [indexPath], with: .automatic)
      delegate?.didUpdateHomeProperty(homeProperty)
    }
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
