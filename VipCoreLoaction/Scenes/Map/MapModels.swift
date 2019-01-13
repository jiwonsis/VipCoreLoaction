//
//  MapModels.swift
//  VipCoreLoaction
//
//  Created by SANGBONG MOON on 13/01/2019.
//  Copyright (c) 2019 Scott Moon. All rights reserved.
//

import UIKit

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
}
