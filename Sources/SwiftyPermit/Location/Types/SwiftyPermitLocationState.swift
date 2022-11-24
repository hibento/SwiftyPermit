//
//  SwiftyPermitLocation+State.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit.Location {
    
    /// Possible permission states
    public enum State {
        
        case virgin
        case whenInUse(Accuracy)
        case always(Accuracy)
        case deniedUser
        case deniedSystem

        // MARK: - Initializer
        
        public init(state: CLAuthorizationStatus,
                    accuracy: CLAccuracyAuthorization) {
            
            switch state {
                        
            case .notDetermined:
                self = .virgin
                
            case .restricted:
                self = .deniedSystem
                
            case .denied:
                self = .deniedUser
                
            case .authorizedAlways:
                self = .always(Accuracy(accuracy))
                
            case .authorizedWhenInUse:
                self = .whenInUse(Accuracy(accuracy))
                
            @unknown default:
                
                logger.error("Unknown CLAuthorizationStatus \(state)")
                self = .virgin
                
            }
            
        }
        
    }
    
}
