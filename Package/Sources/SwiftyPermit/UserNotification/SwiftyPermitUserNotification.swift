//
//  SwiftyPermitUserNotification.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import UserNotifications

extension SwiftyPermit {
    
    public struct UserNotification {

        // MARK: - Relationships
        
        /// UserNotificationCenter (Shortcut)
        let unc = UNUserNotificationCenter.current()
        
        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        public func state(_ requestVariant: Variant? = nil,
                          _ completion: @escaping (State) -> Void) {
            
            unc.getNotificationSettings { settings in
                
                // For now we're ignoring the actual requested user notification request type
                // for the state validation as this is not necessary, but also not 100 %
                // clear how to be handled. We request by default the notification settings
                // permission with alert, sound and badge. They will be granted or not,
                // afterwards the might be disabled again and it's unclear how to react to that
                // in terms of the permission.
                let state = State(settings.authorizationStatus)
                completion(state)
                
            }
            
        }
        
        // MARK: - Check
        
        func isGranted(_ completion: @escaping (Bool) -> Void) {
            
            unc.getNotificationSettings { settings in
           
                switch settings.authorizationStatus {
                
                case .authorized:
                    
                    completion(true)
                    return
                    
                case .denied:
                    
                    completion(false)
                    return
                    
                case .notDetermined:
                    
                    completion(false)
                    return
                    
                case .provisional:
                    
                    // Provisional would allow silent delivery, but this is not really
                    // helpful for our usecase, instead ask for the actual full permission then.
                    completion(false)
                    return
                    
                case .ephemeral:
                    
                    completion(true)
                    return
                    
                @unknown default:
                    
                    logger.error("Unknown notification authorization status \(settings.authorizationStatus)")
                    completion(false)
                    
                }
                
            }
            
        }
        
    }
 
}
