//
//  SwiftyPermitUserNotificationVariant.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import UserNotifications

public struct SwiftyPermitUserNotificationVariant: OptionSet,
                                                   Equatable,
                                                    Hashable {
    
    public static let alert = SwiftyPermitUserNotificationVariant(rawValue: 1 << 0)
    public static let badge = SwiftyPermitUserNotificationVariant(rawValue: 1 << 2)
    public static let sound = SwiftyPermitUserNotificationVariant(rawValue: 1 << 2)

    public let rawValue: Int

    public var unAuthorizationOptions: UNAuthorizationOptions {
        
        var options: UNAuthorizationOptions = []
        
        if contains(.alert) {
            options.insert(.alert)
        }
    
        if contains(.badge) {
            options.insert(.badge)
        }
        
        if contains(.sound) {
            options.insert(.sound)
        }
        
        return options
        
    }
    
    public static var `default`: SwiftyPermitUserNotificationVariant {
        return [.alert, .badge, .sound]
    }
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
}
