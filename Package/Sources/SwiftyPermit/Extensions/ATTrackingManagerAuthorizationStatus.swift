//
//  ATTrackingManagerAuthorizationStatus.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import AppTrackingTransparency

extension ATTrackingManager.AuthorizationStatus: CustomStringConvertible {
    
    public var description: String {
        
        switch self {
            
        case .notDetermined:
            return "notDetermined"
            
        case .restricted:
            return "restricted"
            
        case .authorized:
            return "authorized"
            
        case .denied:
            return "denied"
            
        @unknown default:
            return self.rawValue.description
            
        }
        
    }
    
}
