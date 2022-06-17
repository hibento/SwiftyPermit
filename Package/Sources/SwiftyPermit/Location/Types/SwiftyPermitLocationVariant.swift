//
//  SwiftyPermitLocationVariant.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

/// Possible request types
public enum SwiftyPermitLocationVariant: Codable,
                                         Equatable,
                                         Hashable,
                                         CustomDebugStringConvertible {
    
    case always(SwiftyPermit.Location.Accuracy)
    case whenInUse(SwiftyPermit.Location.Accuracy)
    
    // MARK: - Properties
    
    var requiredInfoPlistKey: SwiftyPermitPlistEntry {
        switch self {
            
        case .always:
            return .keyValue("NSLocationAlwaysAndWhenInUseUsageDescription")
            
        case .whenInUse:
            return .keyValue("NSLocationWhenInUseUsageDescription")
            
        }
    }
    
    public var debugDescription: String {
        
        switch self {
            
        case .always(let accuracy):
            return "Always.\(accuracy.debugDescription)"
            
        case .whenInUse(let accuracy):
            return "WhenInUse.\(accuracy.debugDescription)"
            
        }
        
    }
    
    public var accuracy: SwiftyPermit.Location.Accuracy {
        
        switch self {
            
        case .always(let accuracy):
            return accuracy
            
        case .whenInUse(let accuracy):
            return accuracy
            
        }
        
    }
    
    public var state: SwiftyPermit.Location.State {
        
        switch self {
            
        case .always(let accuracy):
            return .always(accuracy)
            
        case .whenInUse(let accuracy):
            return .whenInUse(accuracy)
            
        }
        
    }
    
    // MARK: - Equatable
    
    public static func == (lhs: SwiftyPermitLocationVariant, rhs: SwiftyPermitLocationVariant) -> Bool {
        
        switch (lhs, rhs) {
            
        case (.always(let lhsAccuracy), .always(let rhsAccuracy)):
            return lhsAccuracy == rhsAccuracy
            
        case (.whenInUse(let lhsAccuracy), .whenInUse(let rhsAccuracy)):
            return lhsAccuracy == rhsAccuracy
            
        default:
            return false
            
        }
        
    }
    
}
