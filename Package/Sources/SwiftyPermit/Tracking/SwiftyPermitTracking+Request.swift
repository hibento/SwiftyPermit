//
//  SwiftyPermitTracking+Response.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 09.06.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import AppTrackingTransparency

extension SwiftyPermit.Tracking {
    
    func request(_ request: SwiftyPermitTrackingRequest) {

        switch state {
        
        case .allowed:
            
            logger.warning("TrackingPermission \(request) already granted")
            
            request.finish(.success(()))
            return
            
        case .deniedSystem:
            
            logger.error("TrackingPermission \(request) denied by system")
            
            request.finish(.failure(.deniedSystem))
            return
            
        case .deniedUser:
            
            logger.warning("TrackingPermission \(request) previously denied by user")
            
            func goToSettings() {
                manager.trackingRequest = request
                manager.openAppSettings()
            }
            
            guard let openSettingsIfNecessary = request.permitOpenSettingsIfNecessary else {
                goToSettings()
                return
            }
            
            openSettingsIfNecessary { granted in
                      
                guard granted else {
                    logger.warning("Switching to app settings denied")
                    request.finish(.failure(.deniedUser))
                    return
                }
                      
                logger.info("Swichting to app settings now")
                goToSettings()
                      
            }
            
        case .virgin:
            doRequest(request)
            return
            
        }
        
    }
    
    private func doRequest(_ request: SwiftyPermitTrackingRequest) {
                
        ATTrackingManager.requestTrackingAuthorization { status in
            self.process(state: .init(status), request: request)
        }
        
    }
        
}
