//
//  SwiftyPermitLocationRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitLocationRequest: SwiftyPermitRequest {
    
    // MARK: - Variables
    
    let actualPermit: SwiftyPermitLocationVariant
    
    /// Purpose key for system permission dialog, strictly optional and
    /// for now only needed for escalation in location permission's accuracy.
    let purposeKey: String?
    
    // MARK: - Initializer
    
    public init(_ permit: SwiftyPermitLocationVariant,
                escalateIfNecessary: Bool = true,
                openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                purposeKey: String? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
        
        self.actualPermit = permit
        self.purposeKey = purposeKey
        
        super.init(permit: .location(permit),
                   escalateIfNecessary: escalateIfNecessary,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
    
    }
    
}
