//
//  SwiftyPermitUserNotificationRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitUserNotificationRequest: SwiftyPermitRequest {
    
    // MARK: - Variables
    
    let actualPermit: SwiftyPermitUserNotificationVariant
    
    // MARK: - Initializer
    
    public init(permit: SwiftyPermitUserNotificationVariant = .default,
                openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
        
        self.actualPermit = permit
        
        super.init(permit: .userNotification(actualPermit),
                   escalateIfNecessary: false,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
        
    }
    
}
