//
//  SwiftyPermitCamera+Response.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.Camera {
    
    func processResponse() {
        
        // Check for optional completion handler for this permission request
        guard let request = manager.cameraRequest else {
            return
        }
        
        // Important: Release completion handler for now
        manager.cameraRequest = nil

        switch state {
        
        case .allowed:
            request.finish(.success(()))
            
        case .deniedSystem:
            request.finish(.failure(.deniedSystem))
            
        case .deniedUser:
            request.finish(.failure(.deniedUser))
            
        case .virgin:
            
            logger.warning("CameraPermission still virgin")
            request.finish(.failure(.deniedSystem))
            
        }
        
    }
    
}
