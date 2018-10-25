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
  
  func deleteAnnotationForHomeProperty(_ homeProperty: HomeProperty, inMapView mapView: MGLMapView?) {
    let annotationsToDelete = mapView?.annotations?.filter { annotation in
      return annotation.title == "\(homeProperty.sheriffNumber)"
    }
    
    guard let annotations = annotationsToDelete else {
      return
    }
    
    mapView?.removeAnnotations(annotations)
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
  
  func addHomeProperty(_ homeProperty: HomeProperty, toMapView mapView: MGLMapView) {
    TLGeoCoder.shared.geocodeAddressString(homeProperty.address) { (placemarks, error) in
      guard
        let placemarks = placemarks,
        let location = placemarks.first?.location
        else {
          return
      }
      
      TLGeoCoder.shared.addHomePropertyMapAnnotation(withAddress: homeProperty.address, atCoordinate: location.coordinate, forHomeProperty: homeProperty, toMapView: mapView)
    }
  }
  
  func addHomeProperties(_ homeProperties: [HomeProperty], toMapView mapView: MGLMapView) {
    for (index, homeProperty) in homeProperties.enumerated() {
      DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(index*600), execute: {
        self.addHomeProperty(homeProperty, toMapView: mapView)
      })
    }
  }
  
  func addHomePropertyMapAnnotation(withAddress address: String,
                        atCoordinate coordinate: CLLocationCoordinate2D,
                        forHomeProperty homeProperty: HomeProperty,
                        toMapView mapView: MGLMapView) {
    let point = CustomPointAnnotation(coordinate: coordinate,
                                      title: "\(homeProperty.sheriffNumber)",
                                      subtitle: homeProperty.address)
    
    point.reuseIdentifier = "customMapAnnotation"
    mapView.addAnnotation(point)
  }
  
  func geocodeAddressString(_ address: String, completionHandler: @escaping ([CLPlacemark]?, Error?) -> Void) {
    geoCoder.geocodeAddressString(address, completionHandler: completionHandler)
  }
}
