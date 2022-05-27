//
//  TrackingPermissionRequest.swift
//
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class TrackingPermissionRequest: PermissionRequest {
    
    // MARK: - Initializer
    
    public init(openSettingsIfNecessary: SwiftyPermit.OpenSettings? = nil,
                _ completion: @escaping (Result<Void, PermissionError>) -> Void) {
                
        super.init(permission: .tracking,
                   escalateIfNecessary: false,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
        
    }
    
}
