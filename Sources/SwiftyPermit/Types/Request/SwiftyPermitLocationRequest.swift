//
//  SwiftyPermitLocationRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitLocationRequest: SwiftyPermitRequestable {
    
    // MARK: - Variables
    
    let actualPermit: SwiftyPermitLocationVariant
        
    public var permitEscalateIfNecessary: Bool
    
    /// Purpose key for system permission dialog, strictly optional and
    /// for now only needed for escalation in location permission's accuracy.
    let purposeKey: String?
    
    // MARK: - Properties
    
    public var permitVariant: SwiftyPermitVariant {
        return .location(actualPermit)
    }
    
    // MARK: - Relationships
    
    public let permitOpenSettingsIfNecessary: SwiftyPermitOpenSettings?
    
    public let permitCompletion: SwiftyPermitRequestCompletion
    
    // MARK: - Initializer
    
    public init(_ permit: SwiftyPermitLocationVariant,
                escalateIfNecessary: Bool = true,
                openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                purposeKey: String? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
        
        self.actualPermit = permit
        self.permitEscalateIfNecessary = escalateIfNecessary
        self.purposeKey = purposeKey
        
        self.permitOpenSettingsIfNecessary = openSettingsIfNecessary
        self.permitCompletion = completion
    
    }
    
}
