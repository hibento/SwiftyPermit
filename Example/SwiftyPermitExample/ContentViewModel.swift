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
        
        let request: SwiftyPermitLocalNetworkRequest = .init { result in

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
        
        let request: SwiftyPermitPhotoLibraryRequest = .init { result in

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
        
        let request: SwiftyPermitCameraRequest = .init { result in

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
        
        let request: SwiftyPermitUserNotificationRequest = .init { result in

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
        
        let request: SwiftyPermitTrackingRequest = .init { result in

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
        
        let request: SwiftyPermitLocationRequest = .init(.whenInUse(.reduced)) { result in

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
        
        let request: SwiftyPermitLocationRequest = .init(.whenInUse(.full),
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
        
        let request: SwiftyPermitLocationRequest = .init(.always(.reduced),
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
        
        let request: SwiftyPermitLocationRequest = .init(.always(.full),
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
