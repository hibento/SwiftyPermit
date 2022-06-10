//
//  SwiftyPermitState.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 03.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    public enum State: Int,
                       Codable,
                       CustomStringConvertible,
                       CustomDebugStringConvertible {
        
        case initNecessary
        case initInProgress
        case initCompleted
        
        public var description: String {
            switch self {
                
            case .initNecessary:
                return "Initialisierung erforderlich"
                
            case .initInProgress:
                return "Initialisierung wird durchgeführt"
                
            case .initCompleted:
                return "Initialisierung abgeschlossen"
                
            }
        }
        
        public var debugDescription: String {
            switch self {
                
            case .initNecessary:
                return "initNecessary"
                
            case .initInProgress:
                return "initInProgress"
                
            case .initCompleted:
                return "initCompleted"
                
            }
        }
        
    }
    
}
