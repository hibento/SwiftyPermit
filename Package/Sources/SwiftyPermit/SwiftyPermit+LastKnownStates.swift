//
//  SwiftyPermit+LastKnownStates.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 18.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    func fetchLastKnownStates() {
        
        logger.info("Unsetting last known permission state due to background transition")
       
        // Don't remove any known state so far.
        // Previously we did this, it seems safe to do so: After a background
        // transition assume the worst: All permissions have been revoked.
        // But this in turn alarms unnecessarly everyone depending on permissions.
        //
        // Instead assume the most likely scenario: Nothing did change, but still
        // check - but without disturbing the current setup (by removing all known
        // states). So we're silently reloading the states and change them if necessary.
        // lastKnownPermissionStates.removeAll()
        
        var permissions: [Permission] = []
        
        if cameraRequest == nil {
            permissions.append(.cameraVideo)
        }
        
        if photoLibraryRequest == nil {
            permissions.append(.photoLibrary)
        }
        
        if userNotificationRequest == nil {
            permissions.append(.userNotification)
        }
        
        if locationRequest == nil {
            permissions.append(.location(.whenInUse(.full)))
        }
        
        if localNetworkRequest == nil {
            permissions.append(.localNetwork)
        }
    
        if trackingRequest == nil {
            permissions.append(.tracking)
        }
        
        logger.info("Fetching last known permissions ...")
                
        hasPermissions(permissions) { _ in
            
            logger.info("Fetched last known permissions")
            self.printLastKnownStates()
            
        }
        
    }
    
    func printLastKnownStates() {
        
        lastKnownPermissionStates.forEach { permission, isGranted in
            
            if let isGranted = isGranted {
                
                if isGranted {
                    logger.info("Permission \(permission): Granted")
                } else {
                    logger.info("Permission \(permission): Denied")
                }
                    
            } else {
                logger.info("Permission \(permission): Unknown")
            }
            
        }
        
    }
    
    func processLastKnownState(old: [Permission: Bool?],
                               new: [Permission: Bool?]) {
        for (permission, isGranted) in new {
            permissionChanged.send(.init(permission: permission,
                                         wasGranted: (old[permission]) ?? nil,
                                         isGranted: isGranted))
        }
        
    }
    
}
