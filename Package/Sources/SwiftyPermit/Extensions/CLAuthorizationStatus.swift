//
//  CLAuthorizationStatus.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension CLAuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
            
        case .notDetermined:
            return "notDetermined"
            
        case .restricted:
            return "restricted"
            
        case .denied:
            return "denied"
            
        case .authorizedAlways:
            return "authorizedAlways"
            
        case .authorizedWhenInUse:
            return "authorizedWhenInUse"
            
        @unknown default:
            return rawValue.description
            
        }
        
    }
    
}
