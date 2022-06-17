//
//  SwiftyPermitVariant.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

public enum SwiftyPermitVariant: Hashable,
                                 Equatable,
                                 CustomStringConvertible,
                                 CustomDebugStringConvertible {
    
    case location(SwiftyPermitLocationVariant)
    case userNotification(SwiftyPermitUserNotificationVariant)
    case cameraVideo
    case photoLibrary
    case localNetwork
    case tracking
    
    // MARK: - Properties
    
    public var description: String {
        return debugDescription
    }
    
    public var debugDescription: String {
        
        switch self {
            
        case .location(let variant):
            return "Location.\(variant.debugDescription)"
            
        case .userNotification:
            return "UserNotifications"
            
        case .cameraVideo:
            return "Camera"
            
        case .photoLibrary:
            return "Photos"
            
        case .localNetwork:
            return "Network"
            
        case .tracking:
            return "Tracking"
            
        }
        
    }
    
    var isCheckableWithoutRequest: Bool {
        
        switch self {
            
        case .location,
                .userNotification,
                .cameraVideo,
                .photoLibrary,
                .tracking:
            return true
            
        case .localNetwork:
            return false
            
        }
        
    }
    
    var requiredPlistEntries: [SwiftyPermitPlistEntry] {
        
        switch self {
            
        case .location(let locationPermission):
            return [locationPermission.requiredInfoPlistKey]
            
        case .userNotification:
            return []
            
        case .cameraVideo:
            return [.keyValue("NSCameraUsageDescription")]
            
        case .photoLibrary:
            return []
            
        case .tracking:
            return [.keyValue("NSUserTrackingUsageDescription")]
            
        case .localNetwork:
            return [.arrayValue(array: "NSBonjourServices", value: "_lnp._tcp.")]
            
        }
        
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: SwiftyPermitVariant, rhs: SwiftyPermitVariant) -> Bool {
        
        // Make sure all known permission are handled.
        switch lhs {
            
        case .location,
                .userNotification,
                .cameraVideo,
                .photoLibrary,
                .localNetwork,
                .tracking:
            break
            
        }
        
        switch (lhs, rhs) {
            
        case (.location(let lhsRequestType), .location(let rhsRequestType)):
            return lhsRequestType == rhsRequestType
            
        case (.userNotification, .userNotification):
            return true
            
        case (.cameraVideo, .cameraVideo):
            return true
            
        case (.photoLibrary, .photoLibrary):
            return true
            
        case (.localNetwork, .localNetwork):
            return true
            
        case (.tracking, .tracking):
            return true
            
        default:
            return false
            
        }
        
    }
    
}
