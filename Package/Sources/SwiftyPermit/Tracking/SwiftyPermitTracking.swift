//
//  SwiftyPermitTracking.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 09.06.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation
import AppTrackingTransparency

extension SwiftyPermit {
    
    public class Tracking {
        
        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        var state: State {
            return .default
        }

        // MARK: - Check
        
        public func isGranted() throws -> Bool {
            
            guard manager.state == .initCompleted else {
                logger.error("SwiftyPermit is not initialized")
                throw SwiftyPermitError.notInitialized
            }
            
            switch state {
            
            case .allowed:
                return true
                
            case .deniedSystem:
                return false
                
            case .deniedUser:
                return false
                
            case .virgin:
                return false
                
            }
            
        }
        
        public func isGranted(_ completion: @escaping (Bool) -> Void) {
            
            func completionHandler(_ result: Bool) {
                completionQueue.async {
                    completion(result)
                }
            }
            
            manager.waitForReadiness {
                
                do {
                    completionHandler(try self.isGranted())
                } catch {
                    completionHandler(false)
                }
                
            }
            
        }
        
    }
    
}
