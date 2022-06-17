//
//  SwiftyPermit+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    func request(_ request: SwiftyPermitRequestable) {
        
        // Usually check for permission state before trying to request it (again).
        // But they're are some exceptions: The NetworkPermission can't be checked
        // without actually requesting it. And we do cover this in the `isGranted`
        // check by throwing an error. So avoid this check here then.
        
        guard request.permitVariant.isCheckableWithoutRequest else {
            doRequest(request)
            return
        }
        
        isGranted(request.permitVariant) { [weak self] alreadyGranted in
            
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
    
    private func doRequest(_ request: SwiftyPermitRequestable) {
        
        // Check: All known permission are handled
        switch request.permitVariant {
            
        case .location,
             .userNotification,
             .photoLibrary,
             .localNetwork,
             .cameraVideo,
             .tracking:
            break
            
        }
        
        for plistEntry in request.permitVariant.requiredPlistEntries {
            
            guard infoPlist(contains: plistEntry) else {
                request.finish(.failure(.plistEntryMissing(plistEntry)))
                return
            }
            
        }
        
        switch request {
            
        case let request as SwiftyPermitLocationRequest:
            location.request(request)
            
        case let request as SwiftyPermitCameraRequest:
            camera.request(request)
            
        case let request as SwiftyPermitPhotoLibraryRequest:
            photoLibrary.request(request)
            
        case let request as SwiftyPermitUserNotificationRequest:
            userNotification.request(request)
            
        case let request as SwiftyPermitLocalNetworkRequest:
            localNetwork.request(request)
 
        case let request as SwiftyPermitTrackingRequest:
            tracking.request(request)
            
        default:
            logger.error("Unknown permission request")
            
        }
        
    }
    
}
