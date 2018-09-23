//
//  AddNewHomePropertyTableViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 9/22/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit
import Mapbox

class AddNewHomePropertyTableViewController: UITableViewController {
  
  weak var delegate: HomePropertyTableViewDelegate?
  
  @IBOutlet weak var sheriffNumberTextField: UITextField!
  @IBOutlet weak var salesDatePicker: UIDatePicker!
  @IBOutlet weak var judgementPriceTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField! 
  @IBOutlet weak var stateTextField: UITextField!
  @IBOutlet weak var cityTextField: UITextField!
  
  var fullAddress: String {
    return "\(addressTextField.text!) \(cityTextField.text!) \(stateTextField.text!)"
  }
  
  @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addressTextFieldEditingDidEnd(_ sender: UITextField) {
    if (sender.text ?? "").isEmpty {
      return
    }
    
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(fullAddress) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
        else {
          return
      }
      
      self.addMapAnnotation(withAddress: self.fullAddress, atCoordinate: location.coordinate)
    }
    
  }
  
  @IBAction func saveNewHomeProperty(_ sender: Any) {
    let newHomeProperty = HomeProperty(
      sheriffNumber: Int(sheriffNumberTextField.text!)!,
      judgementPrice: Double(judgementPriceTextField.text!)!,
      salesDate: salesDatePicker.date,
      address: fullAddress)
    delegate?.didAddNewHomeProperty(newHomeProperty)
    dismiss(animated: true, completion: nil)
  }
  
  @IBOutlet weak var mapView: MGLMapView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func addMapAnnotation(withAddress address: String, atCoordinate coordinate: CLLocationCoordinate2D) {
    let point = CustomPointAnnotation(coordinate: coordinate,
                                      title: address,
      subtitle: nil)

    point.reuseIdentifier = "customMapAnnotation"
    mapView.addAnnotation(point)
  }
}

extension AddNewHomePropertyTableViewController: MGLMapViewDelegate {
  func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
    if let point = annotation as? CustomPointAnnotation,
      let image = point.image,
      let reuseIdentifier = point.reuseIdentifier {
      
      if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
        // The annotatation image has already been cached, just reuse it.
        return annotationImage
      } else {
        // Create a new annotation image.
        return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
      }
    }
    
    // Fallback to the default marker image.
    return nil
  }
  
  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    return true
  }
}
