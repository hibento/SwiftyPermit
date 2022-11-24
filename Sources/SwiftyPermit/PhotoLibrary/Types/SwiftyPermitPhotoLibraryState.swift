//
//  SwiftyPermitPhotoLibraryState.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

extension SwiftyPermit.PhotoLibrary {
        
    /// Possible permission states
    public enum State {
        
        case virgin
        case allowed
        case deniedUser
        case deniedSystem

        public init(_ state: PHAuthorizationStatus) {
            
            switch state {
            
            case .authorized:
                self = .allowed
                
            case .denied:
                self = .deniedUser
                
            case .restricted:
                self = .deniedSystem
                
            case .notDetermined:
                self = .virgin
                
            case .limited:
                self = .allowed
                
            @unknown default:
                
                logger.error("Unknown PHAuthorizationStatus \(state.rawValue.description)")
                self = .virgin
                
            }
            
        }
        
    }
    
}
