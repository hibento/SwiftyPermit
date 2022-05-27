//
//  SwiftyPermitLocationAccuracy.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit.Location {
    
    public enum Accuracy: Int,
                          Codable,
                          CustomDebugStringConvertible,
                          Comparable {
        
        case full = 1
        case reduced = 0
        
        // MARK: - Properties
        
        public var debugDescription: String {
            
            switch self {
                
            case .full:
                return "Full"
                
            case .reduced:
                return "Reduced"
                
            }
            
        }
        
        // MARK: - Initializer
        
        public init(_ accuracy: CLAccuracyAuthorization) {
            
            switch accuracy {
            
            case .fullAccuracy:
                self = .full
                
            case .reducedAccuracy:
                self = .reduced
            
            @unknown default:
                
                logger.error("Unknown accuracy: \(accuracy)")
                self = .reduced
                
            }
            
        }
        
        public static func < (lhs: SwiftyPermit.Location.Accuracy, rhs: SwiftyPermit.Location.Accuracy) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
        
    }
    
}
