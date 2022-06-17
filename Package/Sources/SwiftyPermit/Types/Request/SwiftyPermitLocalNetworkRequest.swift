//
//  SwiftyPermitLocalNetworkRequest.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public final class SwiftyPermitLocalNetworkRequest: SwiftyPermitRequest {
    
    // MARK: - Initializer
    
    public init(openSettingsIfNecessary: SwiftyPermitOpenSettings? = nil,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
                
        super.init(permit: .localNetwork,
                   escalateIfNecessary: false,
                   openSettingsIfNecessary: openSettingsIfNecessary,
                   completion)
        
    }
    
}
