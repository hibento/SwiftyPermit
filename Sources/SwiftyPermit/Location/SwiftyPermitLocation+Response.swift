//
//  SwiftyPermitLocation+Response.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 05.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit.Location {
    
    // The authorization status for CoreLocation has changed. Then we
    // need to post a notification so that anyone interested can act accordingly.
    //
    // Usecase: Roads Tabs and the newly gained location permission should result
    // in a reload based on the new location.
    func processResponse() {
        
        // Check for pending permission request
        guard let request = manager.locationRequest else {
            return
        }
        
        // Important: Release request immediately
        manager.locationRequest = nil

        switch (request.actualPermit, state) {
            
        case (.whenInUse(let expectedAccuracy), .whenInUse(let actualAccuracy)):
            if expectedAccuracy <= actualAccuracy {
                request.finish(.success(()))
            } else {
                request.finish(.failure(.location(.accuracyDenied)))
            }
            
        case (.whenInUse(let expectedAccuracy), .always(let actualAccuracy)):
            if expectedAccuracy <= actualAccuracy {
                request.finish(.success(()))
            } else {
                request.finish(.failure(.location(.accuracyDenied)))
            }
            
        case (.always, .whenInUse):
            request.finish(.failure(.location(.variantDenied)))
            
        case (.always(let expectedAccuracy), .always(let actualAccuracy)):
            if expectedAccuracy <= actualAccuracy {
                request.finish(.success(()))
            } else {
                request.finish(.failure(.location(.accuracyDenied)))
            }
            
        case (_, .deniedUser):
            request.finish(.failure(.deniedUser))

        case (_, .deniedSystem):
            request.finish(.failure(.deniedSystem))

        case (_, .virgin):
            request.finish(.failure(.notDetermined))

        }
        
    }
    
}
