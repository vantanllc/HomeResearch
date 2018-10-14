//
//  TLGeoCoder.swift
//  Home Research
//
//  Created by Thinh Luong on 10/14/18.
//  Copyright © 2018 Vantan LLC. All rights reserved.
//

import MapKit
import Mapbox

class TLGeoCoder {
  static let shared = TLGeoCoder()
  private let geoCoder = CLGeocoder()
  
  private init() {
  }
  
  func addMapAnnotation(withAddress address: String,
                        atCoordinate coordinate: CLLocationCoordinate2D,
                        toMapView mapView: MGLMapView) {
    let point = CustomPointAnnotation(coordinate: coordinate,
                                      title: address,
                                      subtitle: nil)
    
    point.reuseIdentifier = "customMapAnnotation"
    mapView.addAnnotation(point)
  }
  
  func geocodeAddressString(_ address: String, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
    geoCoder.geocodeAddressString(address, completionHandler: completionHandler)
  }
}
