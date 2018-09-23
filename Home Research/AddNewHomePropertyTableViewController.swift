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
  
  @IBAction func dismissViewController(_ sender: UIBarButtonItem) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func addressTextFieldEditingDidEnd(_ sender: UITextField) {
    if (sender.text ?? "").isEmpty {
      return
    }
    
    let fullAddress = "\(sender.text!) \(cityTextField.text!) \(stateTextField.text!)"
    
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(fullAddress) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
        else {
          return
      }
      
      self.addMapAnnotation(withCoordinate: location.coordinate)
    }
    
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
  
  @IBOutlet weak var mapView: MGLMapView!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func addMapAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
//    let coordinate = CLLocationCoordinate2D(latitude: 41.5868,  longitude: -93.598022)
    let point = CustomPointAnnotation(coordinate: coordinate,
                                      title: "Custom Point Annotation",
      subtitle: nil)
    
    // Set the custom `image` and `reuseIdentifier` properties, later used in the `mapView:imageForAnnotation:` delegate method.
    // Create a unique reuse identifier for each new annotation image.
    point.reuseIdentifier = "customAnnotation"
    // This dot image grows in size as more annotations are added to the array.
    point.image = dot(size:10)
    mapView.addAnnotation(point)
  }
  
  func dot(size: Int) -> UIImage {
    let floatSize = CGFloat(size)
    let rect = CGRect(x: 0, y: 0, width: floatSize, height: floatSize)
    let strokeWidth: CGFloat = 1
    
    UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
    
    let ovalPath = UIBezierPath(ovalIn: rect.insetBy(dx: strokeWidth, dy: strokeWidth))
    UIColor.darkGray.setFill()
    ovalPath.fill()
    
    UIColor.white.setStroke()
    ovalPath.lineWidth = strokeWidth
    ovalPath.stroke()
    
    let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return image
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
