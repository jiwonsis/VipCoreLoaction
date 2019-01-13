//
//  MapInteractor.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import CoreLocation

protocol MapBusinessLogic {
    func doSomething(request: Map.Something.Request)
    func requestForCurrentLocation(request: Map.RequestFromCurrentLocation.Request)
}

protocol MapDataStore {
    //var name: String { get set }
}

class MapInteractor: NSObject, MapBusinessLogic, MapDataStore, CLLocationManagerDelegate {
    var presenter: MapPresentationLogic?
    var worker: MapWorker?
    //var name: String = ""
    
    let locationManager = CLLocationManager()
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
    
}
