//
//  SwiftyPermitLocationTransitionType.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.Location {
    
    public enum TransitionType {
        
        /// Permission already granted to full extend (type and accuracy)
        case granted
                
        case virginToWhenInUse(Accuracy)
        case virginToAlways(Accuracy)
        
        case whenInUseToAlways(Accuracy)
        
        /// Permission granted, but not with full accuracy
        case reducedToFullAccuracy
        
        /// Denied by system (e.g. system restricts location by MDM)
        case deniedBySystem
        
        /// Denied by user and now trying to 'whenInUse'
        case deniedByUserToWhenInUse(Accuracy)
        
        /// Denied by user and now trying to 'always'
        case deniedByUserToAlways(Accuracy)
        
        public var requestIsNecessary: Bool {
            
            switch self {
            
            case .granted:
                return false
                
            case .deniedBySystem:
                return false
                
            case .virginToWhenInUse:
                return true
                
            case .virginToAlways:
                return true
                
            case .whenInUseToAlways:
                return true
                
            case .reducedToFullAccuracy:
                return true
                
            case .deniedByUserToWhenInUse:
                return true
                
            case .deniedByUserToAlways:
                return true
                
            }
            
        }
        
        public init(currentState: State, permit: SwiftyPermitLocationVariant) {
            
            switch currentState {
              
            case .virgin:
                
                switch permit {
                
                case .whenInUse(let requestedAccuracy):
                    self = .virginToWhenInUse(requestedAccuracy)
                    
                case .always(let requestedAccuracy):
                    self = .virginToAlways(requestedAccuracy)
                    
                }
                
            case .whenInUse(let currentAccuracy):
                
                switch permit {
                
                case .whenInUse(let requestedAccuracy):
                    
                    if currentAccuracy == requestedAccuracy {
                        self = .granted
                    } else if currentAccuracy == .full {
                        self = .granted
                    } else {
                        self = .reducedToFullAccuracy
                    }
                    
                case .always(let requestedAccuracy):
                    self = .whenInUseToAlways(requestedAccuracy)
                    
                }
                
            case .always(let currentAccuracy):
                
                if currentAccuracy == .full {
                    self = .granted
                } else if currentAccuracy == permit.accuracy {
                    self = .granted
                } else {
                    self = .reducedToFullAccuracy
                }
            
            case .deniedUser:
                
                switch permit {
                
                case .whenInUse(let requestedAccuracy):
                    self = .deniedByUserToWhenInUse(requestedAccuracy)
                    
                case .always(let requestedAccuracy):
                    self = .deniedByUserToAlways(requestedAccuracy)
                    
                }
                
            case .deniedSystem:
                self = .deniedBySystem
                
            }
            
        }
        
    }
    
}
