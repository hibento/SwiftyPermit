//
//  CLAccuracyAuthorization.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension CLAccuracyAuthorization: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
            
        case .fullAccuracy:
            return "fullAccuracy"
            
        case .reducedAccuracy:
            return "reducedAccuracy"
            
        @unknown default:
            return rawValue.description
            
        }
        
    }
    
}
