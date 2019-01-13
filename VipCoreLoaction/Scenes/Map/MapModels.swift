//
//  MapModels.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import MapKit

enum Map {
    // MARK: Use cases
  
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum RequestFromCurrentLocation {
        struct Request {
        }
        struct Response {
            var success: Bool
        }
        struct ViewModel {
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
        }
    }
    
    enum GetCurrentLocation {
        struct Request {
            var mapView: MKMapView
        }
        struct Response {
            var success: Bool
            var error: NSError?
        }
        struct ViewModel {
            var success: Bool
            var errorTitle: String?
            var errorMessage: String?
        } 
    }
    
    enum CenterMap {
        struct Request {
        }
        struct Response {
            var coordinate: CLLocationCoordinate2D
        }
        struct ViewModel {
            var coordinate: CLLocationCoordinate2D
        }
    }
    
    enum GetCurrentAddress {
        struct Request {
        }
        struct Response {
            var success: Bool
        }
        struct ViewModel {
            var success: Bool
        }
    }
}
