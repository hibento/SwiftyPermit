//
//  SwiftyPermit+Request.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    public func request(_ request: PermissionRequest) {
        
        // Usually check for permission state before trying to request it (again).
        // But they're are some exceptions: The NetworkPermission can't be checked
        // without actually requesting it. And we do cover this in the `isGranted`
        // check by throwing an error. So avoid this check here then.
        
        guard request.permission.isCheckableWithoutRequest else {
            doRequest(request)
            return
        }
        
        isGranted(request.permission) { [weak self] alreadyGranted in
            
            guard alreadyGranted == false else {
                request.finish(.success(()))
                return
            }
            
            guard let self = self else {
                logger.error("Deinit")
                request.finish(.failure(.deinit))
                return
            }
            
            self.doRequest(request)
            
        }
        
    }
    
    private func doRequest(_ request: PermissionRequest) {
        
        // Check: All known permission are handled
        switch request.permission {
            
        case .location,
             .userNotification,
             .photoLibrary,
             .localNetwork,
             .cameraVideo,
             .tracking:
            break
            
        }
        
        for infoPListEntry in request.permission.requiredInfoPListEntries {
            
            guard infoPList(contains: infoPListEntry) else {
                request.finish(.failure(.infoPListEntryMissing(infoPListEntry)))
                return
            }
            
        }
        
        switch request {
            
        case let request as LocationPermissionRequest:
            location.request(request)
            
        case let request as CameraPermissionRequest:
            camera.request(request)
            
        case let request as PhotoLibraryPermissionRequest:
            photoLibrary.request(request)
            
        case let request as UserNotificationPermissionRequest:
            userNotification.request(request)
            
        case let request as LocalNetworkPermissionRequest:
            localNetwork.request(request)
 
        case let request as TrackingPermissionRequest:
            tracking.request(request)
            
        default:
            logger.error("Unknown permission request")
            
        }
        
    }
    
}
