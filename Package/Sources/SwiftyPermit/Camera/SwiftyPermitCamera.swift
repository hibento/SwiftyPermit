//
//  SwiftyPermitCamera.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation

extension SwiftyPermit {
    
    public struct Camera {

        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        public var state: State {
            
            let avAuthorizationState = AVCaptureDevice.authorizationStatus(for: .video)
            return State(avAuthorizationState)
            
        }
        
        // MARK: - Check
        
        public func isGranted() throws -> Bool {
            
            guard manager.state == .initCompleted else {
                logger.error("SwiftyPermit is not initialized")
                throw PermissionError.notInitialized
            }
            
            let state = self.state
            
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
                    let isGranted = try self.isGranted()
                    completionHandler(isGranted)
                } catch {
                    completionHandler(false)
                }
                
            }
          
        }
        
    }
 
}
