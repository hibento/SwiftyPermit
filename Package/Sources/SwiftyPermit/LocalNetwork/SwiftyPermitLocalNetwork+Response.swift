//
//  SwiftyPermitLocalNetwork+Response.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 13.11.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.LocalNetwork {
    
    func processResponse() {

        // Check for optional completion handler for this permission request
        guard let request = manager.localNetworkRequest else {
            logger.debug("No Network request is set - we're good")
            return
        }
        
        // Important: Release completion handler for now
        manager.localNetworkRequest = nil
        
        // Check state
        state(request.finish(_:))
        
    }

}
