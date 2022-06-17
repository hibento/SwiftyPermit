//
//  SwiftyPermitRequest.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

public class SwiftyPermitRequest: CustomStringConvertible {
    
    // MARK: - Variables
    
    /// Requested permission,
    /// e.g. gallery, camera or location
    public let permit: SwiftyPermitVariant
    
    /// Escale permission if necessary,
    /// e.g. location accuracy or from 'whenInUse' to 'Always'
    public let escalateIfNecessary: Bool
    
    /// Open / go to app settings if necessary (user denied a previous request)
    public let openSettingsIfNecessary: SwiftyPermitOpenSettings?
        
    // MARK: - Relationships
    
    private let completion: SwiftyPermitRequestCompletion
    
    // MARK: - Properties
    
    public var description: String {
        return permit.description
    }
    
    var manager: SwiftyPermit {
        return .shared
    }
    
    // MARK: - Initializer
    
    public init(permit: SwiftyPermitVariant,
                escalateIfNecessary: Bool,
                openSettingsIfNecessary: SwiftyPermitOpenSettings?,
                _ completion: @escaping SwiftyPermitRequestCompletion) {
        
        self.permit = permit
        self.escalateIfNecessary = escalateIfNecessary
        self.openSettingsIfNecessary = openSettingsIfNecessary
        
        self.completion = completion
        
    }
    
    public final func execute() {
        SwiftyPermit.shared.request(self)
    }
    
    public final func finish(_ result: Result<Void, SwiftyPermitError>) {
        
        // Ensure we're caching this permission state.
        switch result {
            
        case .failure:
            manager.lastKnownPermitStates[permit] = false

        case .success:
            manager.lastKnownPermitStates[permit] = true

        }

        SwiftyPermit.completionQueue.async {
            self.completion(result)
        }
    }
    
}
