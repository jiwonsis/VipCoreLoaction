//
//  PlacemarkViewController.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 19/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

protocol PlacemarkDisplayLogic: class {
    func displaySomething(viewModel: Placemark.Something.ViewModel)
    func displayShowPhysicalAddress(viewModel: Placemark.ShowPhysicalAddress.ViewModel)
}

class PlacemarkViewController: UITableViewController, PlacemarkDisplayLogic {
    var interactor: PlacemarkBusinessLogic?
    var router: (NSObjectProtocol & PlacemarkRoutingLogic & PlacemarkDataPassing)?

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
        let interactor = PlacemarkInteractor()
        let presenter = PlacemarkPresenter()
        let router = PlacemarkRouter()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showPhysicalAddress()
    }
  
    // MARK: Do something
  
    //@IBOutlet weak var nameTextField: UITextField!
  
    func doSomething() {
        let request = Placemark.Something.Request()
        interactor?.doSomething(request: request)
    }
  
    func displaySomething(viewModel: Placemark.Something.ViewModel) {
        //nameTextField.text = viewModel.name
    }
    
    // MARK: Show physical address
    
    func showPhysicalAddress() {
        let request = Placemark.ShowPhysicalAddress.Request()
        interactor?.showPhysicalAddress(request: request)
    }
    
    func displayShowPhysicalAddress(viewModel: Placemark.ShowPhysicalAddress.ViewModel) {
        var cell = tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.thoroughfare
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 1, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.subThoroughfare
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 2, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.locality
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 3, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.subLocality
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 4, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.administrativeArea
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 5, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.subAdministrativeArea
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 6, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.postalCode
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 7, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.country
        
        cell = tableView(tableView, cellForRowAt: IndexPath(row: 8, section: 0))
        cell.detailTextLabel?.text = viewModel.placemark.isoCountryCode
        
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
}
