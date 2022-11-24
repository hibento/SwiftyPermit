//
//  SwiftyPermitUserNotificationRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitUserNotificationRequest: SwiftyPermitRequestable {
    
    // MARK: - Variables
    
    let actualPermit: SwiftyPermitUserNotificationVariant
    
    public let permitEscalateIfNecessary: Bool = false
    
    // MARK: - Relationships
    
    public let permitOpenSettingsIfNecessary: SwiftyPermitOpenSettings?
    
    public let permitCompletion: SwiftyPermitRequestCompletion
    
    // MARK: - Properties
    
    public var permitVariant: SwiftyPermitVariant {
        return .userNotification(actualPermit)
    }
    
    // MARK: - Initializer
    
    public init(permit: SwiftyPermitUserNotificationVariant = .default,
                openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
        
        self.actualPermit = permit
        
        self.permitOpenSettingsIfNecessary = openSettingsIfNecessary
        self.permitCompletion = completion
        
    }
    
}
