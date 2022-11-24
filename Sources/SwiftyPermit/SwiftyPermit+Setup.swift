//
//  SwiftyPermit+Setup.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 27.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import UIKit

extension SwiftyPermit {
        
    func setup() {
        
        setupLocationManager()
        setupNotifications()
        
    }
    
    private func setupLocationManager() {
        
        // Init locationManager on mainThread
        if Thread.isMainThread == false {
            
            logger.warning("LocationManager must be initialized on mainThread")
            
            DispatchQueue.main.sync {
                self.setupLocationManager()
            }
            
            return
            
        }
        
        location.locationManager.delegate = self
        
        // Dummy-call to authorization state, as this will make sure we won't
        // get any unexpected authorization state change delegate call.
        logger.info("LocationManager authorizationStatus: \(self.location.locationManager.authorizationStatus)")
        
    }
    
    final func setupNotifications() {
        let nc: NotificationCenter = .default
        
        nc.addObserver(self,
                       selector: #selector(applicationDidBecomeActive(_:)),
                       name: UIApplication.didBecomeActiveNotification,
                       object: nil)
        
        nc.addObserver(self,
                       selector: #selector(applicationWillResignActive(_:)),
                       name: UIApplication.willResignActiveNotification,
                       object: nil)
        
        nc.addObserver(self,
                       selector: #selector(applicationDidEnterBackground(_:)),
                       name: UIApplication.didEnterBackgroundNotification,
                       object: nil)
        
    }
    
}
