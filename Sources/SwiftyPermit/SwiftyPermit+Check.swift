//
//  SwiftyPermit+Check.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    /// Combines the requests for several permissions by requesting them async
    /// and simultaneously.
    public func hasPermits(_ permits: [SwiftyPermitVariant],
                           _ completion: @escaping ([SwiftyPermitVariant: Bool?]) -> Void) {
        
        var states: [SwiftyPermitVariant: Bool?] = [:]
        let dispatchGroup = DispatchGroup()
        
        for permit in permits {
            
            dispatchGroup.enter()
            
            isGranted(permit) { granted in
                
                states[permit] = granted
                dispatchGroup.leave()
                
            }
            
        }
        
        dispatchGroup.notify(queue: completionQueue) {
            completion(states)
        }
        
    }
    
    /// A convenience method for `hasPermission` in terms that for a given set
    /// of permission we're getting back a pure `Boolean` value.
    public func areGranted(_ permits: [SwiftyPermitVariant],
                           _ completion: @escaping (Bool?) -> Void) {
        
        hasPermits(permits) { permits in
            
            let areGranted: Bool?
            
            if permits.contains(where: { $0.value == nil }) {
                
                // There's one (1) unknown state, probably NetworkPermission.
                areGranted = nil
                
            } else if permits.contains(where: { (_, value) in
                
                // There's at least one permission explicitly set to false.
                guard let value = value else {
                    return true
                }
                
                return value == false
                
            }) {
                areGranted = false
            } else {
                areGranted = true
            }
            
            completion(areGranted)
            
        }
        
    }
    
    /// Checks the state of the given permission.
    /// It doesn't request the permission if denied, unknown or virgin.
    /// This is a pure state check.
    public func isGranted(_ permit: SwiftyPermitVariant,
                          _ completion: @escaping (Bool?) -> Void) {
        
        func completionHandler(_ granted: Bool?) {
            
            // Ensure we're caching this permission state.
            lastKnownPermitStates[permit] = granted
            
            // Redirect the callback.
            completionQueue.async {
                completion(granted)
            }
            
        }
        
        switch permit {
            
        case .location(let variant):
            location.isGranted(variant, completionHandler(_:))
            
        case .userNotification:
            userNotification.isGranted(completionHandler(_:))
            
        case .cameraVideo:
            camera.isGranted(completionHandler(_:))
            
        case .photoLibrary:
            photoLibrary.isGranted(completionHandler(_:))
            
        case .localNetwork:
            localNetwork.isGranted(completionHandler(_:))
            
        case .tracking:
            tracking.isGranted(completionHandler(_:))
            
        }
        
    }
    
}
