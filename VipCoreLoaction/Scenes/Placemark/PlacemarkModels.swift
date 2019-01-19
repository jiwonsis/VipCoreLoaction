//
//  PlacemarkModels.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 19/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit
import MapKit

enum Placemark {
    // MARK: Use cases
  
    enum Something {
        struct Request {
        }
        struct Response {
        }
        struct ViewModel {
        }
    }
    
    enum ShowPhysicalAddress {
        struct Request {
        }
        struct Response {
            var placemark: MKPlacemark
        }
        struct ViewModel {
            var placemark: MKPlacemark
        }
    }
    
}
