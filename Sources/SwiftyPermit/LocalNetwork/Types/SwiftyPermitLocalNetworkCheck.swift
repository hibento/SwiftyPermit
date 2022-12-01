//
//  SwiftyPermitLocalNetworkCheck.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 07.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import UIKit
import Combine

extension SwiftyPermit.LocalNetwork {
    
    /// Checks for the current permission state for local network access.
    /// As there's no public API to do so, we're relying on a workaround:
    /// https://stackoverflow.com/a/67758105/2953963
    class Check: NSObject, NetServiceDelegate {
        
        // MARK: - Typealias
        
        typealias Completion = (Bool) -> Void
        
        // MARK: - Variables
        
        var isPublishing = false
        
        /// Keep track if the timer already detected a denied permission request
        /// in the current cycle. This will be used to check at least twice before
        /// finally assuming we did fail. That because sometimes the failure gets
        /// detected to early, probably due to some internal load.
        private var didFailedInCurrentCycle: Bool = false
        
        // MARK: - Relationships
        
        lazy var service: NetService = {
            
            let service: NetService = .init(domain: "local.",
                                            type: "_lnp._tcp",
                                            name: "LocalNetworkPrivacy",
                                            port: 1100)
            service.delegate = self
            return service
            
        }()
        
        let completion: Completion
                
        // MARK: - Subscriptions
        
        private var timerSubscriptions = Set<AnyCancellable>()
        
        // MARK: - Initializer
        
        init(_ completion: @escaping Completion) {
            
            self.completion = completion
            super.init()
            setup()
            
        }
        
        // MARK: - Setup
        
        private func setup() {
            // Nothing (yet)
        }
        
        private func setupTimer() {
            
            guard timerSubscriptions.isEmpty else {
                logger.info("LocalNetworkCheck is already running ...")
                return
            }
            
            logger.info("LocalNetworkCheck is starting ...")
                        
            Timer.publish(every: 2, on: .main, in: .common)
                .autoconnect()
                .sink { [weak self] _ in
                    self?.firedTimer()
                }.store(in: &timerSubscriptions)

        }
        
        private func firedTimer() {
            
            // This is important as it's ensures the potential system
            // dialog for the permission (result in an inactive state)
            // will keep the timer running while ignoring the current
            // publishing state. In short: Wait for the user's decision!
            guard UIApplication.shared.applicationState == .active else {
                logger.info("LocalNetworkCheck postponed ...")
                return
            }
            
            // First timer call (i.e. isPublishing is not set), we need
            // to setup a publisher and see if this works, i.e. we've got
            // the permissions. If the publisher has already been started
            // (ergo this is the second call) this would mean the permission
            // has not been granted, because otherwise the callback from the
            // publisher would have stopped the timer.
            
            if isPublishing {
                
                // Wait two (2) cycles before finally declaring we're done.
                if didFailedInCurrentCycle {
                    
                    logger.info("LocalNetworkCheck: IsNotGranted")
                    completionHandler(false)
                    
                } else {
                    didFailedInCurrentCycle = true
                }
                
            } else {
                
                logger.info("LocalNetworkCheck is running ...")
                
                isPublishing = true
                service.publish()
                
            }
            
        }
        
        // MARK: - NetServiceDelegate
        
        func netServiceDidPublish(_ sender: NetService) {
            
            logger.info("LocalNetworkCheck: IsGranted")
            completionHandler(true)
            
        }
        
        // MARK: - Completion
        
        private func completionHandler(_ isGranted: Bool) {
            
            timerSubscriptions.removeAll()            
            isPublishing = false
            didFailedInCurrentCycle = false
            service.stop()
            
            completion(isGranted)
            
        }
        
        // MARK: - IsGranted
        
        func execute() throws {
            setupTimer()
        }
        
    }
    
}
