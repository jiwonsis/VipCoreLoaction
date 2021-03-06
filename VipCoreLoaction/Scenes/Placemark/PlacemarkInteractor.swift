//
//  PlacemarkInteractor.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 19/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import MapKit

protocol PlacemarkBusinessLogic {
    func doSomething(request: Placemark.Something.Request)
    func showPhysicalAddress(request: Placemark.ShowPhysicalAddress.Request)
}

protocol PlacemarkDataStore {
    //var name: String { get set }
    var placemark: MKPlacemark! { get set }
}

class PlacemarkInteractor: PlacemarkBusinessLogic, PlacemarkDataStore {
    var presenter: PlacemarkPresentationLogic?
    var worker: PlacemarkWorker?
    //var name: String = ""
    var placemark: MKPlacemark!
  
     // MARK: Do something
  
    func doSomething(request: Placemark.Something.Request) {
        worker = PlacemarkWorker()
        worker?.doSomeWork()
    
        let response = Placemark.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
    // MARK: Show physical address
    
    func showPhysicalAddress(request: Placemark.ShowPhysicalAddress.Request) {
        let response = Placemark.ShowPhysicalAddress.Response(placemark: placemark)
        presenter?.presentShowPhysicalAddress(response: response)
    }
}
