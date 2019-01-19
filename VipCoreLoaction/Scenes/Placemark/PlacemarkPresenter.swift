//
//  PlacemarkPresenter.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 19/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol PlacemarkPresentationLogic {
    func presentSomething(response: Placemark.Something.Response)
    func presentShowPhysicalAddress(response: Placemark.ShowPhysicalAddress.Response)
}

class PlacemarkPresenter: PlacemarkPresentationLogic {
    weak var viewController: PlacemarkDisplayLogic?
  
    // MARK: Do something
  
    func presentSomething(response: Placemark.Something.Response) {
        let viewModel = Placemark.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
    // MARK: Show physical address
    func presentShowPhysicalAddress(response: Placemark.ShowPhysicalAddress.Response) {
        let viewModel = Placemark.ShowPhysicalAddress.ViewModel(placemark: response.placemark)
        viewController?.displayShowPhysicalAddress(viewModel: viewModel)
    }
}
