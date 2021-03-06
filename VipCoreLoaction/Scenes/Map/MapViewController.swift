//
//  MapViewController.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import MapKit

protocol MapDisplayLogic: class {
    func displaySomething(viewModel: Map.Something.ViewModel)
    func displayRequestForCurrentLocation(viewModel: Map.RequestFromCurrentLocation.ViewModel)
    func displayGetCurrentLocation(viewModel: Map.GetCurrentLocation.ViewModel)
    func displayCenterMap(viewModel: Map.CenterMap.ViewModel)
    func displayGetCurrentAddress(viewModel: Map.GetCurrentAddress.ViewModel)
}

class MapViewController: UIViewController, MapDisplayLogic {
    var interactor: MapBusinessLogic?
    var router: (NSObjectProtocol & MapRoutingLogic & MapDataPassing)?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var getAddressButton: UIBarButtonItem!

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
  
    private func setup() {
        let viewController = self
        let interactor = MapInteractor()
        let presenter = MapPresenter()
        let router = MapRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        doSomething()
        requestForCurrentLocation()
    }
  
    // MARK: Do something
  
    //@IBOutlet weak var nameTextField: UITextField!
  
    func doSomething() {
        let request = Map.Something.Request()
        interactor?.doSomething(request: request)
    }
  
    func displaySomething(viewModel: Map.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    
    // MARK: Request for current location
    
    func requestForCurrentLocation() {
        let request = Map.RequestFromCurrentLocation.Request()
        interactor?.requestForCurrentLocation(request: request)
    }
    
    func displayRequestForCurrentLocation(viewModel: Map.RequestFromCurrentLocation.ViewModel) {
        if viewModel.success {
            mapView.showsUserLocation = true
            getCurrentLocation()
        } else {
            showAlert(title: viewModel.errorTitle!, message: viewModel.errorMessage!)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Get Current Location
    
    func getCurrentLocation() {
        let request = Map.GetCurrentLocation.Request(mapView: mapView)
        interactor?.getCurrentLocation(request: request)
    }
    
    func displayGetCurrentLocation(viewModel: Map.GetCurrentLocation.ViewModel) {
        if viewModel.success {
            centerMap()
            getCurrentAddress()
        } else {
            showAlert(title: viewModel.errorTitle!, message: viewModel.errorMessage!)
        }
    }
    
    // MARK: Center Map
    
    func centerMap() {
        let request = Map.CenterMap.Request()
        interactor?.centerMap(request: request)
    }
    
    func displayCenterMap(viewModel: Map.CenterMap.ViewModel) {
        mapView.setCenter(viewModel.coordinate, animated: true)
    }
    
    // MARK: Get Current Address
    
    func getCurrentAddress(){
        let request = Map.GetCurrentAddress.Request()
        interactor?.getCurrentAddress(request: request)
    }
    
    func displayGetCurrentAddress(viewModel: Map.GetCurrentAddress.ViewModel) {
        getAddressButton.isEnabled = viewModel.success
    }
}

