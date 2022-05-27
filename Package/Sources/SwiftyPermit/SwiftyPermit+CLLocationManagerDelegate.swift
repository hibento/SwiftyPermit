//
//  SwiftyPermit+CLLocationManagerDelegate.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import UIKit
import CoreLocation

extension SwiftyPermit: CLLocationManagerDelegate {
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        processAuthorizationChange()
    }
    
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        processAuthorizationChange()
    }
    
    private func processAuthorizationChange() {
        logger.info("🛰 PermissionDidChange: \(self.state.description)")

        // Don't react to changes in the permission while the App is the background.
        // That's because moving the app to the background always (!) triggers
        // (for some reasons) a 'didChangeAuthorization status' call. This will
        // mess with our internal logic and will call the completion handler here
        // to early (before the user actually granted or not granted us the permission).
        if runsInBackground {
            logger.info("🛰 Skipped permission processing due to background state")
            return
        }
      
        guard locationRequest != nil else {
            logger.debug("🛰 Skipped permission processing")
            return
        }
        
        location.processResponse()
    }
    
}
