//
//  MapPresenter.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import MapKit

protocol MapPresentationLogic {
    func presentSomething(response: Map.Something.Response)
    func presentRequestForCurrentLocation(response: Map.RequestFromCurrentLocation.Response)
    func presentGetCurrentLocation(response: Map.GetCurrentLocation .Response)
    func presentCenterMap(response: Map.CenterMap.Response)
    func presentGetCurrentAddress(response: Map.GetCurrentAddress.Response)
}

class MapPresenter: MapPresentationLogic {
    weak var viewController: MapDisplayLogic?
  
    // MARK: Do something
  
    func presentSomething(response: Map.Something.Response) {
        let viewModel = Map.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    // MARK: Request for current location
    
    func presentRequestForCurrentLocation(response: Map.RequestFromCurrentLocation.Response) {
        
        var viewModel: Map.RequestFromCurrentLocation.ViewModel
        
        let errorTitle = "Location Disabled"
        let errorMessage = "Please enable location service in th Settings"
        
        if response.success {
            viewModel = Map.RequestFromCurrentLocation.ViewModel(success: true, errorTitle: nil, errorMessage: nil)
        } else {
            viewModel = Map.RequestFromCurrentLocation.ViewModel(success: false, errorTitle: errorTitle, errorMessage: errorMessage)
        }
        
        viewController?.displayRequestForCurrentLocation(viewModel: viewModel)
    }
    
    // MARK: Get Current Location
    
    func presentGetCurrentLocation(response: Map.GetCurrentLocation.Response) {
        
        var viewModel: Map.GetCurrentLocation.ViewModel
        if response.success {
            viewModel = Map.GetCurrentLocation.ViewModel(success: true, errorTitle: nil, errorMessage: nil)
        } else {
            let errorTitle = "Error"
            let errorMessage: String?
            if response.error?.code == CLError.locationUnknown.rawValue {
                errorMessage = "Your location could not be determined."
            } else {
                errorMessage = response.error?.localizedDescription
            }
            
            viewModel = Map.GetCurrentLocation.ViewModel(success: false, errorTitle: errorTitle, errorMessage: errorMessage)
        }
        
        viewController?.displayGetCurrentLocation(viewModel: viewModel)
    }
    
    // MARK: Center Map
    
    func presentCenterMap(response: Map.CenterMap.Response) {
        let viewModel = Map.CenterMap.ViewModel(coordinate: response.coordinate)
        viewController?.displayCenterMap(viewModel: viewModel)
    }
    
    
    // MARK: Get Current Address
    
    func presentGetCurrentAddress(response: Map.GetCurrentAddress.Response) {
        let viewModel = Map.GetCurrentAddress.ViewModel(success: response.success)
        viewController?.displayGetCurrentAddress(viewModel: viewModel)
    }
}
