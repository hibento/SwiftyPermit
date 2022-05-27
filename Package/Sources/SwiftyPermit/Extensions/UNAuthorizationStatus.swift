//
//  UNAuthorizationStatus.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import UserNotifications

extension UNAuthorizationStatus: CustomStringConvertible {

    public var description: String {
        
        switch self {
            
        case .notDetermined:
            return "notDetermined"
            
        case .denied:
            return "denied"
            
        case .authorized:
            return "authorized"
            
        case .provisional:
            return "provisional"
            
        case .ephemeral:
            return "ephemeral"
            
        @unknown default:
            return rawValue.description
            
        }
        
    }
    
}
