//
//  SwiftyPermit+PhotoLibrary.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 12.10.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

extension SwiftyPermit {
    
    public struct PhotoLibrary {

        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        public var state: State {
            
            let state = PHPhotoLibrary.authorizationStatus()
            return State(state)
            
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
                return true
                
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
