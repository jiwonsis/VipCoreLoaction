//
//  MapPresenter.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol MapPresentationLogic {
    func presentSomething(response: Map.Something.Response)
    func presentRequestForCurrentLocation(response: Map.RequestFromCurrentLocation.Response)
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
}
