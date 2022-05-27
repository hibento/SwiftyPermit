//
//  LocationPermissionRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class LocationPermissionRequest: PermissionRequest {
    
    // MARK: - Variables
    
    let variant: SwiftyPermit.Location.Variant
    
    /// Purpose key for system permission dialog, strictly optional and
    /// for now only needed for escalation in location permission's accuracy.
    let purposeKey: String?
    
    // MARK: - Initializer
    
    public init(_ variant: SwiftyPermit.Location.Variant,
                escalateIfNecessary: Bool = true,
                openSettingsIfNecessary: SwiftyPermit.OpenSettings? = nil,
                purposeKey: String? = nil,
                _ completion: @escaping (Result<Void, PermissionError>) -> Void) {
        
        self.variant = variant
        self.purposeKey = purposeKey
        
        super.init(permission: .location(variant),
                   escalateIfNecessary: escalateIfNecessary,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
    
    }
    
}
