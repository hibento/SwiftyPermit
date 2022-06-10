//
//  SwiftyPermitCamera+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation

extension SwiftyPermit.Camera {
    
    func request(_ request: SwiftyPermitCameraRequest) {

        switch state {
        
        case .allowed:
            
            logger.warning("CameraPermission already granted")
            
            request.finish(.success(()))
            return
            
        case .deniedSystem:
            
            logger.error("CameraPermission denied by system")
            
            request.finish(.failure(.deniedSystem))
            return
            
        case .deniedUser:
            
            logger.warning("CameraPermission previously denied by user")
            
            func goToSettings() {
                manager.cameraRequest = request
                manager.openAppSettings()
            }
            
            guard let openSettingsIfNecessary = request.openSettingsIfNecessary else {
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
    
    private func doRequest(_ request: SwiftyPermitCameraRequest) {
                        
        AVCaptureDevice.requestAccess(for: .video) { granted in
 
            if granted {
                logger.info("CameraPermission granted")
                request.finish(.success(()))
                return
            } else {
                logger.warning("CameraPermission not granted")
                request.finish(.failure(.deniedUser))
                return
            }
            
        }
        
    }

}
