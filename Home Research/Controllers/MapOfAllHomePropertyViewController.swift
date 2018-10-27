//
//  MapOfAllHomePropertyViewController.swift
//  Home Research
//
//  Created by Thinh Luong on 10/24/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import UIKit
import Mapbox

class MapOfAllHomePropertyViewController: UIViewController {
  @IBOutlet weak var mapView: MGLMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    mapView.delegate = self
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
}

extension MapOfAllHomePropertyViewController: MGLMapViewDelegate {
  func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
    return true
  }
  
  func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
    
    if let castAnnotation = annotation as? MyCustomPointAnnotation {
      if (castAnnotation.willUseImage) {
        return nil
      }
    }
    
    // Assign a reuse identifier to be used by both of the annotation views, taking advantage of their similarities.
    let reuseIdentifier = "reusableDotView"
    
    // For better performance, always try to reuse existing annotations.
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
    
    // If there’s no reusable annotation view available, initialize a new one.
    if annotationView == nil {
      annotationView = MGLAnnotationView(reuseIdentifier: reuseIdentifier)
      annotationView?.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
      annotationView?.layer.cornerRadius = (annotationView?.frame.size.width)! / 2
      annotationView?.layer.borderWidth = 4.0
      annotationView?.layer.borderColor = UIColor.white.cgColor
      annotationView!.backgroundColor = UIColor(red: 0.03, green: 0.80, blue: 0.69, alpha: 1.0)
    }
    
    return annotationView
  }
}
