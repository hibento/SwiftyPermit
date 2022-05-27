//
//  SwiftyPermitCameraState.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation

extension SwiftyPermit.Camera {
    
    /// Possible permission states
    public enum State {
        
        case virgin
        case allowed
        case deniedUser
        case deniedSystem

        public init(_ state: AVAuthorizationStatus) {
            
            switch state {
            
            case .authorized:
                self = .allowed
            
            case .denied:
                self = .deniedUser
            
            case .restricted:
                self = .deniedSystem
            
            case .notDetermined:
                self = .virgin
           
            @unknown default:
            
                logger.error("Unknown AVAuthorizationStatus \(state)")
                self = .virgin
            
            }
            
        }
        
    }
    
}
