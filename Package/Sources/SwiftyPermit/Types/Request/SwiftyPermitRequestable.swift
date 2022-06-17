//
//  SwiftyPermitRequestable.swift
//  
//
//  Created by Christian Steffens on 17.06.22.
//

import Foundation

public protocol SwiftyPermitRequestable: CustomStringConvertible {
    
    /// Requested permission,
    /// e.g. gallery, camera or location
    var permitVariant: SwiftyPermitVariant { get }
    
    /// Escale permission if necessary,
    /// e.g. location accuracy or from 'whenInUse' to 'Always'
    var permitEscalateIfNecessary: Bool { get }
    
    /// Requests permission to open the App settings to grant a permission that
    /// was previousy denied. If this callback is not set, the settings will be
    /// open if nessary without the user's explicit consent.
    var permitOpenSettingsIfNecessary: SwiftyPermitOpenSettings? { get }
        
    /// Callback for the requests completion.
    /// Returns (a void) success in case the permission was granted,
    /// an error otherwise (including a potential cancellation of the request).
    var permitCompletion: SwiftyPermitRequestCompletion { get }
    
}

extension SwiftyPermitRequestable {
    
    public var description: String {
        return permitVariant.debugDescription
    }
    
    private var manager: SwiftyPermit {
        return .shared
    }
    
    public func execute() {
        manager.request(self)
    }
    
    public func finish(_ result: Result<Void, SwiftyPermitError>) {
        
        // Ensure we're caching this permission state.
        switch result {
            
        case .failure:
            manager.lastKnownPermitStates[permitVariant] = false

        case .success:
            manager.lastKnownPermitStates[permitVariant] = true

        }

        SwiftyPermit.completionQueue.async {
            self.permitCompletion(result)
        }
    }
    
}
