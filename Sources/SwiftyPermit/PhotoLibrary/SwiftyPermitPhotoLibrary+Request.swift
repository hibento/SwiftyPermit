//
//  SwiftyPermit+PhotoLibrary+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

extension SwiftyPermit.PhotoLibrary {
    
    func request(_ request: SwiftyPermitPhotoLibraryRequest) {

        switch state {
        
        case .allowed:
            
            logger.warning("PhotoLibraryPermission already granted")
            request.finish(.success(()))
            return
            
        case .deniedSystem:
            
            logger.error("PhotoLibraryPermission denied by system")
            request.finish(.failure(.deniedSystem))
            return
            
        case .deniedUser:
            
            logger.warning("PhotoLibraryPermission previously denied by user")
            
            func goToSettings() {
                manager.photoLibraryRequest = request
                manager.openAppSettings()
            }
            
            guard let openSettingsIfNecessary = request.permitOpenSettingsIfNecessary else {
                goToSettings()
                return
            }
            
            openSettingsIfNecessary { granted in
                
                guard granted else {
                    logger.warning("Switching to app settings denied")
                    request.finish(.failure(.deniedUser))
                    return
                }
                
                logger.info("Swichting to app settings now")
                goToSettings()
                
            }

        case .virgin:
            doRequest(request)
            return
            
        }
        
    }
    
    private func doRequest(_ request: SwiftyPermitPhotoLibraryRequest) {
        
        logger.debug("PhotoLibraryPermission always granted since iOS 14")
            
        request.finish(.success(()))
        return
        
    }

}
