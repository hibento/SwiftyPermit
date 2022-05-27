//
//  SwiftyPermitLocation.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit {
    
    public class Location {
        
        // MARK: - Relationships
        
        /// CoreLocationManager
        var locationManager: CLLocationManager = .init()
        
        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        public var state: State {

            let state = locationManager.authorizationStatus
            let accuracy = locationManager.accuracyAuthorization
            
            return State(state: state, accuracy: accuracy)

        }
 
        // MARK: - Check
        
        public func isGranted(_ requestVariant: Variant) throws -> Bool {
            
            guard manager.state == .initCompleted else {
                logger.error("SwiftyPermit is not initialized")
                throw PermissionError.notInitialized
            }
            
            let transition = Location.TransitionType(currentState: state,
                                                     requestVariant: requestVariant)
            
            // If not transition is necessary, then the permission is already granted
            return transition.requestIsNecessary == false
            
        }
        
        public func isGranted(_ requestVariant: Variant,
                              _ completion: @escaping (Bool) -> Void) {
            
            func completionHandler(_ result: Bool) {
                completionQueue.async {
                    completion(result)
                }
            }
            
            manager.waitForReadiness {
                
                do {
                    
                    let permissionGranted = try self.isGranted(requestVariant)
                    completionHandler(permissionGranted)
                    
                } catch {
                    completionHandler(false)
                }
                
            }
            
        }
        
    }
        
}
