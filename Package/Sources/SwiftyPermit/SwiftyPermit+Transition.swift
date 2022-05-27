//
//  SwiftyPermit+Transition.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 18.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    func transitionForegroundBackgroundForeground() {
        
        logger.info("Transition foreground → background → foreground")
                    
        location.transitionForegroundBackgroundForeground()
        camera.transitionForegroundBackgroundForeground()
        photoLibrary.transitionForegroundBackgroundForeground()
        userNotification.transitionForegroundBackgroundForeground()
        localNetwork.transitionForegroundBackgroundForeground()
        tracking.transitionForegroundBackgroundForeground()
        
        fetchLastKnownStates()
        
    }
    
    func transitionActiveInactiveActive() {
        
        logger.info("Transition active → inactive → active")
 
    }
    
}
