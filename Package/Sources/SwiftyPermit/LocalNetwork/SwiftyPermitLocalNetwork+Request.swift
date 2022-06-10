//
//  SwiftyPermitLocalNetwork+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 13.11.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.LocalNetwork {
    
    func request(_ request: SwiftyPermitLocalNetworkRequest) {
 
        state { result in
            
            switch result {
            
            case .success:
                
                logger.info("NetworkPermission already granted")
                
                request.finish(.success(()))
                return

            case .failure(let error):
                
                if case .deniedUser = error {
                    logger.warning("NetworkPermission previously denied by user")
                } else {
                    logger.error("NetworkPermission failed due to unexpected error: \(error.localizedDescription)")
                }

                func goToSettings() {
                    self.manager.localNetworkRequest = request
                    self.manager.openAppSettings()
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

            }
            
        }
        
    }

}
