//
//  PermissionRequest.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

public class PermissionRequest: CustomStringConvertible {
    
    // MARK: - Variables
    
    /// Requested permission,
    /// e.g. gallery, camera or location
    public let permission: Permission
    
    /// Escale permission if necessary,
    /// e.g. location accuracy or from 'whenInUse' to 'Always'
    public let escalateIfNecessary: Bool
    
    /// Open / go to app settings if necessary (user denied a previous request)
    public let openSettingsIfNecessary: SwiftyPermit.OpenSettings?
        
    // MARK: - Relationships
    
    private let completion: (Result<Void, PermissionError>) -> Void
    
    // MARK: - Properties
    
    public var description: String {
        return permission.description
    }
    
    var manager: SwiftyPermit {
        return .shared
    }
    
    // MARK: - Initializer
    
    public init(permission: Permission,
                escalateIfNecessary: Bool,
                openSettingsIfNecessary: SwiftyPermit.OpenSettings?,
                _ completion: @escaping (Result<Void, PermissionError>) -> Void) {
        
        self.permission = permission
        self.escalateIfNecessary = escalateIfNecessary
        self.openSettingsIfNecessary = openSettingsIfNecessary
        
        self.completion = completion
        
    }
    
    public final func execute() {
        SwiftyPermit.shared.request(self)
    }
    
    public final func finish(_ result: Result<Void, PermissionError>) {
        
        // Ensure we're caching this permission state.
        switch result {
            
        case .failure:
            manager.lastKnownPermissionStates[permission] = false

        case .success:
            manager.lastKnownPermissionStates[permission] = true

        }

        SwiftyPermit.completionQueue.async {
            self.completion(result)
        }
    }
    
}
