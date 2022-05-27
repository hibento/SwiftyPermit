//
//  SwiftyPermitUserNotificationRequestState.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation
import UserNotifications

extension SwiftyPermit.UserNotification {
    
    public enum State {
        
        case virgin
        case allowed
        case deniedUser
        case deniedSystem

        // MARK: - Initializer
        
        public init(_ state: UNAuthorizationStatus) {
            
            switch state {
            
            case .authorized:
                self = .allowed
                
            case .denied:
                self = .deniedUser
                
            case .provisional:
                self = .allowed
                
            case .notDetermined:
                self = .virgin
                
            case .ephemeral:
                self = .allowed
                
            @unknown default:
                logger.error("Unknown AVAuthorizationStatus \(state)")
                self = .virgin
            }
            
        }
        
    }
    
}
