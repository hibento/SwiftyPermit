//
//  SwiftyPermitUserNotification+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import UIKit
import UserNotifications

extension SwiftyPermit.UserNotification {
    
    func request(_ request: SwiftyPermitUserNotificationRequest) {
                
        let options = request.actualPermit.unAuthorizationOptions
        
        unc.requestAuthorization(options: options) { granted, error in

            if let error = error {
                logger.error("Requesting NotificationPermission failed: \(error.localizedDescription)")
                request.finish(.failure(.system(error)))
                return
            } else if granted {
                DispatchQueue.main.async(execute: {
                    UIApplication.shared.registerForRemoteNotifications()
                    request.finish(.success(()))
                    return
                })
            } else {
                logger.warning("UserNotification not denied, but not specifically granted")
                request.finish(.failure(.deniedSystem))
                return
            }
        }
    }
}
