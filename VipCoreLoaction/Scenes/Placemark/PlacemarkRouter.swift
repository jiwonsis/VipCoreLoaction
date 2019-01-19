//
//  PlacemarkRouter.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 19/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

@objc protocol PlacemarkRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol PlacemarkDataPassing {
    var dataStore: PlacemarkDataStore? { get }
}

class PlacemarkRouter: NSObject, PlacemarkRoutingLogic, PlacemarkDataPassing {
    weak var viewController: PlacemarkViewController?
    var dataStore: PlacemarkDataStore?
  
    // MARK: Routing
    
    // func routeToSomewhere(segue: UIStoryboardSegue?) {
    //     if let segue = segue {
    //         let destinationVC = segue.destination as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //     } else {
    //         let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //         let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //         var destinationDS = destinationVC.router!.dataStore!
    //         passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //         navigateToSomewhere(source: viewController!, destination: destinationVC)
    //     }
    // }

    // MARK: Navigation
  
    // func navigateToSomewhere(source: PlacemarkViewController, destination: SomewhereViewController) {
    //     source.show(destination, sender: nil)
    // }
  
    // MARK: Passing data
  
    // func passDataToSomewhere(source: PlacemarkDataStore, destination: inout SomewhereDataStore) {
    //     destination.name = source.name
    // }
}
