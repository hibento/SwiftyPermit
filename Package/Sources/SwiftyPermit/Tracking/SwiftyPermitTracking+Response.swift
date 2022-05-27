//
//  SwiftyPermitTracking+Response.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 09.06.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import AppTrackingTransparency

extension SwiftyPermit.Tracking {

    func processResponse() {
        
        // Check for pending permission request
        guard let request = manager.trackingRequest else {
            return
        }
        
        // Important: Release request immediately
        manager.trackingRequest = nil
        
        process(state: .default, request: request)

    }
    
    func process(state: State,
                 request: TrackingPermissionRequest) {
        
        switch state {
        
        case .allowed:
            request.finish(.success(()))
            
        case .deniedSystem:
            request.finish(.failure(.deniedSystem))
            
        case .deniedUser:
            request.finish(.failure(.deniedUser))
            
        case .virgin:
            
            logger.warning("TrackingPermission still virgin")
            request.finish(.failure(.deniedSystem))
            
        }
        
    }
    
}
