//
//  SwiftyPermitLocalNetwork.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit {
    
    public final class LocalNetwork {

        // MARK: - Relationships
        
        lazy var check: Check = setupNetworkCheck(verbose: false)
        
        var stateCompletionHandler: [((Result<Void, PermissionError>) -> Void)] = []
        
        // MARK: - Properties
        
        var manager: SwiftyPermit {
            return .shared
        }
        
        // MARK: - Initialiser
        
        init() {
            
        }
        
        // MARK: - Setup
        
        private func setupNetworkCheck(verbose: Bool) -> Check {
            
            return .init { [weak self] isGranted in
                
                guard let self = self else {
                    logger.warning("Deinit")
                    return
                }
                
                logger.info("Local network permission isGranted \(isGranted)")
                
                if isGranted {
                    self.completionHandler(.success(()))
                } else {
                    self.completionHandler(.failure(.deniedUser))
                }
                
            }
            
        }
        
        // MARK: - IsGranted
        
        public func isGranted(_ completion: @escaping (Bool?) -> Void) {
            
            func completionHandler(_ result: Bool?) {
                completionQueue.async {
                    completion(result)
                }
            }
            
            manager.waitForReadiness {
                
                // As soon as we requested the permission once, i.e. explicitly
                // by the user, we're free to check it everytime again.
                //
                // Remember: A mere permission check already triggers the dialog,
                // so don't do anything before the user did not indeed requested
                // it once.
                guard Self.permissionRequestedOnce else {
                    logger.warning("Requesting NetworkPermission is not possible without requesting it - please explicitly request it at least once")
                    completionHandler(nil)
                    return
                }
                
                self.state { result in
                    
                    switch result {
                        
                    case .success:
                        completionHandler(true)
                        
                    case .failure:
                        completionHandler(false)
                        
                    }
                    
                }

            }
            
        }
        
        // MARK: - CompletionHandler
        
        func completionHandler(_ result: Result<Void, PermissionError>) {
            
            manager.completionQueue.async {
                
                let handlers = self.stateCompletionHandler
                self.stateCompletionHandler.removeAll()
                handlers.forEach({ $0(result) })
                
            }
            
        }
          
    }
    
}
