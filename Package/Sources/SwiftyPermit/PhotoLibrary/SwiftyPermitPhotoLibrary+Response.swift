//
//  SwiftyPermit+PhotoLibrary+Response.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.PhotoLibrary {
    
    func processResponse() {
        
        // Check for optional completion handler for this permission request
        guard let request = manager.photoLibraryRequest else {
            return
        }
        
        // Important: Release completion handler for now
        manager.photoLibraryRequest = nil
        
        switch state {
        
        case .allowed:
            request.finish(.success(()))
            
        case .deniedSystem:
            request.finish(.failure(.deniedSystem))
        
        case .deniedUser:
            request.finish(.failure(.deniedUser))
            
        case .virgin:
            
            logger.warning("PhotoLibraryPermission still virgin")
            request.finish(.failure(.deniedSystem))
            
        }
        
    }
    
}
