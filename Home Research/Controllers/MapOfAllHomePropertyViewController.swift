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
}
