//
//  SwiftyPermitUserNotification+Response.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.UserNotification {
    
    func processResponse() {
        
        // Check for optional completion handler for this permission request
        guard let request = manager.userNotificationRequest else {
            return
        }
        
        // Important: Release completion handler for now
        manager.userNotificationRequest = nil

        state { state in
            self.process(state: state, request: request)
        }
        
    }
    
    func process(state: SwiftyPermit.UserNotification.State,
                 request: UserNotificationPermissionRequest) {
        
        switch state {
            
        case .allowed:
            request.finish(.success(()))
            
        case .deniedUser:
            request.finish(.failure(.deniedUser))
            
        case .deniedSystem:
            request.finish(.failure(.deniedSystem))
            
        case .virgin:
            logger.warning("UserNotificationPermission still virgin")
            request.finish(.failure(.deniedSystem))
            
        }
        
    }
    
}
