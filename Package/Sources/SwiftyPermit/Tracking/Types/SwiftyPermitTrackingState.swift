//
//  SwiftyPermitTrackingState.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 09.06.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import AVFoundation
import AppTrackingTransparency

extension SwiftyPermit.Tracking {
    
    /// Possible permission states
    public enum State {
        
        case virgin
        case allowed
        case deniedUser
        case deniedSystem
        
        static var `default`: State {
            return .init(ATTrackingManager.trackingAuthorizationStatus)
        }

        public init(_ status: ATTrackingManager.AuthorizationStatus) {
            
            switch status {
                
            case .denied:
                self = .deniedUser
                
            case .authorized:
                self = .allowed
                
            case .notDetermined:
                self = .virgin
                
            case .restricted:
                self = .deniedSystem
                
            @unknown default:
                
                logger.warning("Unknown tracking state \(status)")
                self = .virgin
                
            }
            
        }
        
    }
    
}
