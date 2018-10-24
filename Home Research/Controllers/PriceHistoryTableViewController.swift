//
//  AddPriceTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/21/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit

class PriceHistoryTableViewController: UIViewController {
  
  var homeProperty: HomeProperty!
  weak var delegate: PriceHistoryDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  var tapBGGesture: UITapGestureRecognizer!
  
  override func viewDidAppear(_ animated: Bool) {
    tapBGGesture = UITapGestureRecognizer(target: self, action: #selector(onTap(sender:)))
    tapBGGesture.delegate = self
    tapBGGesture.numberOfTapsRequired = 1
    tapBGGesture.cancelsTouchesInView = false
    self.view.window!.addGestureRecognizer(tapBGGesture)
  }

  override func viewWillDisappear(_ animated: Bool) {
    self.view.window!.removeGestureRecognizer(tapBGGesture)
  }
  
}

extension PriceHistoryTableViewController: UIGestureRecognizerDelegate {
  @objc private func onTap(sender: UITapGestureRecognizer) {
    self.view.window?.removeGestureRecognizer(sender)
    self.dismiss(animated: true, completion: nil)
  }
  
  internal func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
    let location = touch.location(in: self.view)
    
    if self.view.point(inside: location, with: nil) {
      return false
    }
    else {
      return true
    }
  }
  
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}

extension PriceHistoryTableViewController: UITableViewDataSource, UITableViewDelegate {
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
