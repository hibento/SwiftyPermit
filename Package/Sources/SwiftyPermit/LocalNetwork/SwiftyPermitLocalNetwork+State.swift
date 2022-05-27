//
//  SwiftyPermitLocalNetwork+State.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 08.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.LocalNetwork {
    
    // MARK: - State
    
    /// Checks the local network permission state for the given type.
    /// Optional the state check can be (en)forced, in regard that the
    /// state can normally only be checked after (!) the permission has been
    /// requested at least once.
    public func state(_ completion: @escaping (Result<Void, PermissionError>) -> Void) {
        
        // Enqueue request
        stateCompletionHandler.append(completion)
                
        do {
            
            try check.execute()
            
            // At this point it's important to persist the fact, that the permission
            // state for the local network has been requested once (explicitly).
            // So we're free to request it any time from now (implicitly).
            Self.permissionRequestedOnce = true
            
        } catch let error as PermissionError {
            completion(.failure(error))
        } catch {
            completion(.failure(.system(error)))
        }
        
    }
    
}
