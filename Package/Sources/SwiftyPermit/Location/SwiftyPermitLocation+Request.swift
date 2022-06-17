//
//  SwiftyPermitLocation+Request.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 05.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import CoreLocation

extension SwiftyPermit.Location {
    
    func request(_ request: SwiftyPermitLocationRequest) {

        manager.waitForReadiness { [weak self] in
            
            guard let self = self else {
                request.finish(.failure(.deinit))
                return
            }

            let currentState = self.state
            let transition = TransitionType(currentState: currentState,
                                            permit: request.actualPermit)
        
            switch transition {
                
            // Permission was already granted, we're good
            case .granted:
                request.finish(.success(()))
                
            // Permission is denied explicitly by system (i.e. system restriction)
            case .deniedBySystem:
                request.finish(.failure(.restricted))
                
            // Request when in use permission
            case .virginToWhenInUse:
                self.virginToWhenInUse(request)
          
            // Request or esqualate to always permission
            case .virginToAlways:
                self.virginToAlways(request)
                
            // Escalate to always permission
            case .whenInUseToAlways:
                self.whenInUseToAlways(request)
                
            // Escale reduced to full accuracy
            case .reducedToFullAccuracy:
                self.reducedToFullAccuracy(request)
            
            // Permission was denied, sent user to app setting
            case .deniedByUserToWhenInUse,
                 .deniedByUserToAlways:
                self.deniedByUser(request)
                
            }
            
        }
        
    }
    
    private func virginToWhenInUse(_ request: SwiftyPermitLocationRequest) {
        manager.locationRequest = request
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func virginToAlways(_ request: SwiftyPermitLocationRequest) {
        manager.locationRequest = request
        locationManager.requestAlwaysAuthorization()
    }
    
    private func whenInUseToAlways(_ request: SwiftyPermitLocationRequest) {
        guard request.permitEscalateIfNecessary else {
            logger.warning("Always requested, but escalation prohibited")
            request.finish(.failure(.deniedUser))
            return
        }

        manager.locationRequest = request
        locationManager.requestAlwaysAuthorization()
    }
    
    private func reducedToFullAccuracy(_ request: SwiftyPermitLocationRequest) {

        guard request.permitEscalateIfNecessary else {
            logger.warning("Full accuracy requested, but escalation prohibited")
            request.finish(.failure(.deniedUser))
            return
        }
        
        guard let purposeKey = request.purposeKey else {
            logger.error("PurposeKey is not set")
            request.finish(.failure(.location(.purposeKeyIsMissing)))
            return
        }
        
        let dictionary: String = "NSLocationTemporaryUsageDescriptionDictionary"
        let entry: SwiftyPermitPlistEntry = .dictionaryKey(dictionary: dictionary, key: purposeKey)
        
        guard let purposeValue = manager.infoPlistValue(entry) else {
            logger.error("PurposeKey \(purposeKey) not found")
            request.finish(.failure(.plistEntryMissing(entry)))
            return
        }

        logger.info("Using purposeKey '\(purposeKey)' and purposeVaue '\(purposeValue)'")
                
        locationManager.requestTemporaryFullAccuracyAuthorization(withPurposeKey: purposeKey) { [weak self] error in
                    
            guard let self = self else {
                logger.error("Deinit")
                request.finish(.failure(.deinit))
                return
            }
            
            if let error = error {
                        
                logger.warning("Escaling LocationPermission's accuracy failed: \(error.localizedDescription)")
                request.finish(.failure(.deniedUser))

            } else {
                        
                // Error is not set, but that doesn't mean the
                // accuracy is given. We need to check this
                // explicitly.
                        
                let accuracy = self.locationManager.accuracyAuthorization
                        
                switch accuracy {
                        
                case .fullAccuracy:
                            
                    logger.info("LocationPermission escaled from reduced to full accuracy")
                    request.finish(.success(()))
                        
                case .reducedAccuracy:
                            
                    logger.warning("Escaling LocationPermission's accuracy denied")
                    request.finish(.failure(.deniedUser))
                            
                @unknown default:
                            
                    logger.error("Unknown location permission accuracy: \(accuracy)")
                    request.finish(.failure(.deniedSystem))

                }
                    
            }
                    
        }

    }
    
    private func deniedByUser(_ request: SwiftyPermitLocationRequest) {

        guard request.permitEscalateIfNecessary else {
            logger.warning("LocationPermission whenInUse was denied by user")
            request.finish(.failure(.deniedUser))
            return
        }
            
        func goToSettings() {
            
            self.manager.locationRequest = request
            
            // Important: This a bugfix for a weird behaviour noticed
            // in the field - under some unknown cirumstances the user
            // didn't denied at any time the location permission request.
            // But the system authorization state tells us otherwise.
            // So we'll send the user to the app settings to manually
            // change the permission settings. Unfortunately this is not
            // possible then, since we never requested the permission in
            // the first place, i.e. the necessary switch is not visible
            // in the app's settings.
            //
            // Therefore we're triggering a dummy request here. In case
            // the user didn't triggered any permission request this will
            // ensure that the switch is at least visible in the app
            // settings (and the user isn't effectivly locked out). If
            // the permission was requested once, this call will do nothing,
            // no error message, no delegate call - so for the positive case
            // this call has no side effects. But for the potential system
            // bug this ensures the necessary permission switch is available.
            locationManager.requestAlwaysAuthorization()
            
            manager.openAppSettings()
        }
        
        guard let openSettingsIfNecessary = request.permitOpenSettingsIfNecessary else {
            goToSettings()
            return
        }
        
        openSettingsIfNecessary { granted in
            
            guard granted else {
                logger.warning("Switching to app settings denied")
                request.finish(.failure(.deniedUser))
                return
            }
            
            logger.info("Swichting to app settings now")
            goToSettings()
            
        }
        
    }
    
}
