//
//  SwiftyPermit+Notification.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 05.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit {

    @objc func applicationDidBecomeActive(_ notification: NSNotification) {
        
        logger.info("applicationDidBecomeActive")
        
        // If the app was suspended and now became active we need to tell the
        // system about a potential (!) permission change. The importance lies
        // here on the word 'potential' - it's perfectly valid to have no
        // permission change at all - e.g. user switched to his messaging app.
        if wasSuspended {
            transitionForegroundBackgroundForeground()
        }
        
        if wasInactive {
            transitionActiveInactiveActive()
        }
        
        // Unset all lifecycle related properties
        wasSuspended = false
        wasInactive = false
        
    }
    
    @objc func applicationDidEnterBackground(_ notification: NSNotification) {
        
        logger.info("applicationDidEnterBackground")
        
        // App become supsended here, this property will be used to detect a complete
        // transition foreground → background → foreground. This excludes (!) any
        // potential part transition (e.g. opening the app switcher, but immediately
        // going back to our app).
        wasSuspended = true
        
    }
    
    @objc func applicationWillResignActive(_ notification: NSNotification) {
        
        logger.info("applicationWillResignActive")
        
        // App become inactive here. Was with didEnterBackground keep track
        // of the lifecycle for potential permission checks.
        wasInactive = true
        
    }
    
}
