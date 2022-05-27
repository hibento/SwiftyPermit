//
//  SwiftyPermitUserNotificationVariant.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import UserNotifications

extension SwiftyPermit.UserNotification {
    
    /// Possible request types
    public typealias Variant = UNAuthorizationOptions
    
    public static var defaultVariant: Variant {
        return [.alert, .badge, .sound]
    }
    
}
