//
//  ContentViewModel.swift
//  Permission Manager Example
//
//  Created by Christian Steffens on 08.06.22.
//

import Foundation
import SwiftyPermit

struct ContentViewModel {

    // MARK: - LocalNetwork

    func requestLocalNetwork() {
        
        let request: LocalNetworkPermissionRequest = .init { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    // MARK: - Camera & Photos

    func requestPhotoLibrary() {
        
        let request: PhotoLibraryPermissionRequest = .init { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    func requestCamera() {
        
        let request: CameraPermissionRequest = .init { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    // MARK: - User Notification

    func requestUserNotification() {
        
        let request: UserNotificationPermissionRequest = .init { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    // MARK: - Tracking

    func requestTracking() {
        
        let request: TrackingPermissionRequest = .init { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    // MARK: - Location
    
    func requestLocationWhenInUseReduced() {
        
        let request: LocationPermissionRequest = .init(.whenInUse(.reduced)) { result in

            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
    func requestLocationWhenInUseFull() {
        
        let request: LocationPermissionRequest = .init(.whenInUse(.full),
                                                       escalateIfNecessary: true,
                                                       purposeKey: "LocationAccuracyEscalationReason") { result in
            
            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
 
    func requestLocationAlwaysReduced() {
        
        let request: LocationPermissionRequest = .init(.always(.reduced),
                                                       escalateIfNecessary: true,
                                                       openSettingsIfNecessary: nil,
                                                       purposeKey: nil) { result in
            
            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
 
    func requestLocationAlwaysFull() {
        
        let request: LocationPermissionRequest = .init(.always(.full),
                                                       escalateIfNecessary: true,
                                                       openSettingsIfNecessary: nil,
                                                       purposeKey: "LocationAccuracyEscalationReason") { result in
            
            switch result {
                
            case .failure(let error):
                print("Requesting permission failed: \(error)")
                
            case .success:
                print("Requested permission")
                
            }
            
        }
        
        SwiftyPermit.shared.request(request)
    }
    
}
