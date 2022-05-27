//
//  UserNotificationPermissionRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class UserNotificationPermissionRequest: PermissionRequest {
    
    // MARK: - Variables
    
    let variant: SwiftyPermit.UserNotification.Variant
    
    // MARK: - Initializer
    
    public init(variant: SwiftyPermit.UserNotification.Variant = SwiftyPermit.UserNotification.defaultVariant,
                openSettingsIfNecessary: SwiftyPermit.OpenSettings? = nil,
                _ completion: @escaping (Result<Void, PermissionError>) -> Void) {
        
        self.variant = variant
        
        super.init(permission: .userNotification,
                   escalateIfNecessary: false,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
        
    }
    
}
