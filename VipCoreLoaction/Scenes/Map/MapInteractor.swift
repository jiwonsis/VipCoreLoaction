//
//  MapInteractor.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

protocol MapBusinessLogic {
    func doSomething(request: Map.Something.Request)
    func requestForCurrentLocation(request: Map.RequestFromCurrentLocation.Request)
    func getCurrentLocation(request: Map.GetCurrentLocation.Request)
    func centerMap(request: Map.CenterMap.Request)
    func getCurrentAddress(request: Map.GetCurrentAddress.Request)
}

protocol MapDataStore {
    //var name: String { get set }
}

class MapInteractor: NSObject, MapBusinessLogic, MapDataStore, CLLocationManagerDelegate, MKMapViewDelegate {
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    //var name: String = ""
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var centerMapFirstTime = false
    var currentLocation: MKUserLocation?
    var placeMark: CLPlacemark?
    
    // MARK: Do something
  
    func doSomething(request: Map.Something.Request) {
        worker = MapWorker()
        worker?.doSomeWork()
    
        let response = Map.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    // MARK: Request for current location
    
    func requestForCurrentLocation(request: Map.RequestFromCurrentLocation.Request) {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        var response: Map.RequestFromCurrentLocation.Response
        
        switch status {
        case .authorizedWhenInUse:
            response = Map.RequestFromCurrentLocation.Response(success: true)
        case .restricted, .denied:
            response = Map.RequestFromCurrentLocation.Response(success: false)
        default:
            return
        }
        
        presenter?.presentRequestForCurrentLocation(response: response)
    }
    
    // MARK: Get Current Location
    
    func getCurrentLocation(request: Map.GetCurrentLocation.Request) {
        request.mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        currentLocation = userLocation
        let response = Map.GetCurrentLocation.Response(success: true, error: nil)
        presenter?.presentGetCurrentLocation(response: response)
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        currentLocation = nil
        let response = Map.GetCurrentLocation.Response(success: false, error: error as NSError)
        presenter?.presentGetCurrentLocation(response: response)
    }
    
    // MARK: Center Map
    
    func centerMap(request: Map.CenterMap.Request) {
        
        if !centerMapFirstTime, let currentLocation = currentLocation {
            let response = Map.CenterMap.Response(coordinate: currentLocation.coordinate)
            presenter?.presentCenterMap(response: response)
            centerMapFirstTime = true
        }
    }
    
    // MARK: Get Current Address
    
    func getCurrentAddress(request: Map.GetCurrentAddress.Request) {
        if let location = currentLocation?.location {
            geocoder.reverseGeocodeLocation(location) { (placeMarks, error) in
                var response: Map.GetCurrentAddress.Response
                if let placeMark = placeMarks?.first {
                    self.placeMark = placeMark
                    response = Map.GetCurrentAddress.Response(success: true)
                } else {
                    response = Map.GetCurrentAddress.Response(success: false)
                }
                self.presenter?.presentGetCurrentAddress(response: response)
            }
            
            
        }
    }
    
}
