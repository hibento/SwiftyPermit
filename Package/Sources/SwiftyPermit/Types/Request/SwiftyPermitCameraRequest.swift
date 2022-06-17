//
//  SwiftyPermitCameraRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitCameraRequest: SwiftyPermitRequestable {
    
    // MARK: - Constants
    
    public let permitVariant: SwiftyPermitVariant = .cameraVideo
    
    public let permitEscalateIfNecessary: Bool = false
    
    // MARK: - Relationships
    
    public let permitOpenSettingsIfNecessary: SwiftyPermitOpenSettings?
    
    public let permitCompletion: SwiftyPermitRequestCompletion
    
    // MARK: - Initializer
    
    public init(openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
       
        self.permitOpenSettingsIfNecessary = openSettingsIfNecessary
        self.permitCompletion = completion
        
    }
    
}
