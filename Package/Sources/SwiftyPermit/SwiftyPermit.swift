//
//  SwiftyPermit.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 01.09.19.
//  Copyright © 2019 hibento. All rights reserved.
//

import UIKit
import Combine

public final class SwiftyPermit: NSObject {
    
    // MARK: - Typealias
    
    public typealias RequestCompletion = (Result<Void, PermissionError>) -> Void
    public typealias OpenSettings = (@escaping (Bool) -> Void) -> Void
    public typealias ReadinessCompletion = ((Result<Void, PermissionError>) -> Void)
    
    // MARK: - Singleton
    
    public static var shared: SwiftyPermit = SwiftyPermit()
    
    // MARK: - Constants
    
    let text: String = "Hello, World!"
    
    // Important: The initialization of the locationManager has to happen
    // on the mainQueue. That's why the init queue is also the main queue.
    static let initQueue: DispatchQueue = .main
    
    static let workQueue: DispatchQueue = DispatchQueue(label: "de.hibento.SwiftyPermit.work", qos: .userInteractive)
    
    static let completionQueue: DispatchQueue = .main
    
    // MARK: - Variables
    
    private (set) public var state: State = .initNecessary
    
    internal (set) public var lastKnownPermissionStates: [Permission: Bool?] = [:] {
        didSet {
            processLastKnownState(old: oldValue, new: lastKnownPermissionStates)
        }
    }
    
    // Optional: Completion handler for a 'waiting for readiness' receiver.
    private var waitingForReadiness: [ReadinessCompletion] = []
    
    /// Completion handler for location permission request that couldn't be
    /// resolved immediately, e.g. user needs to switch to the app settings.
    var locationRequest: LocationPermissionRequest?
    
    /// Completion handler for camera permission request that couldn't be
    /// resolved immediately, e.g. user needs to switch to the app settings.
    var cameraRequest: CameraPermissionRequest?
  
    /// Completion handler for user notification permission request that couldn't be
    /// resolved immediately, e.g. user needs to switch to the app settings.
    var userNotificationRequest: UserNotificationPermissionRequest?

    /// Completion handler for camera permission request that couldn't be
    /// resolved immediately, e.g. user needs to switch to the app settings.
    var photoLibraryRequest: PhotoLibraryPermissionRequest?
    
    /// Completion handler for local network permission request that couldn't be
    /// resolved immediately, e.g. user needs to switch to the app settings.
    var localNetworkRequest: LocalNetworkPermissionRequest?

    var trackingRequest: TrackingPermissionRequest?
    
    /// Verbose logging
    public var verbose: Bool = false
    
    /// Keeps track of any transition of the app from foreground → background → foreground
    var wasSuspended: Bool = false {
        didSet {
            guard wasSuspended else {
                return
            }
            
            logger.info("App was / is suspended")
        }
    }
    
    /// Keeps track of any transition of the app from being active → inactive → active
    var wasInactive: Bool = false {
        didSet {
            guard wasInactive else {
                return
            }
            
            logger.info("App was / is inactive")
        }
    }
    
    public var isReady: Bool {
        
        switch state {
            
        case .initNecessary:
            return false
            
        case .initInProgress:
            return false
            
        case .initCompleted:
            return true
            
        }
        
    }
    
    var runsInBackground: Bool {
        return runsInForeground == false
    }
    
    var runsInForeground: Bool {
        let appState = UIApplication.shared.applicationState
        
        switch appState {
            
        case .background:
            return false
            
        case .active,
             .inactive:
            return true
            
        @unknown default:
            logger.error("Unknown applicationState \(appState.rawValue)")
            return false
            
        }
    }
    
    // MARK: - Publisher
    
    public let permissionChanged = PassthroughSubject<PermissionChanged, Never>()
    
    // MARK: - Relationships
    
    lazy var camera: Camera = .init()
    lazy var localNetwork: LocalNetwork = .init()
    lazy var location: Location = .init()
    lazy var photoLibrary: PhotoLibrary = .init()
    lazy var userNotification: UserNotification = .init()
    lazy var tracking: Tracking = .init()
    
    // MARK: - Properties
    
    /// Default initQueue
    var initQueue: DispatchQueue {
        return Self.initQueue
    }
    
    /// Default workQueue
    var workQueue: DispatchQueue {
        return Self.workQueue
    }
    
    /// Default completionQueue
    var completionQueue: DispatchQueue {
        return Self.completionQueue
    }
    
    public var localNetworkPermissionRequestedOnce: Bool {
        return LocalNetwork.permissionRequestedOnce
    }
    
    // MARK: - Initializer
    
    private override init() {

        super.init()

        initialize { result in
            
            switch result {
                
            case .failure(let error):
                logger.error("Initializing SwiftyPermit failed: \(error.localizedDescription)")
                
            case .success:
                logger.info("Initialized SwiftyPermit")
                
            }
            
        }
    }
    
    private func initialize(_ completion: @escaping (Result<Void, PermissionError>) -> Void) {
        
        func completionHandler(_ result: Result<Void, PermissionError>) {
            completionQueue.async {
                
                // Don't forget any potential enqueued readiness call here.
                self.waitingForReadiness.forEach({ $0(result) })
                self.waitingForReadiness.removeAll()
                
                completion(result)
                
            }
        }

        initQueue.async {
            
            switch self.state {
                
            case .initNecessary:
                // First call to the initialize routine, so just keep progressing.
                self.state = .initInProgress
                
            case .initInProgress:
                
                // Initialize has already being called, but it's still ongoing.
                // So queue this call for later resolving.
                self.waitingForReadiness.append(completion)
                
                // Important: Do return now.
                return
                
            case .initCompleted:
                
                // Initialize already completed, we're done here.
                completionHandler(.success(()))
                
                // Important: Do return now
                return
                
            }
            
            self.setup()
            
            // And now we're done
            self.state = .initCompleted
            
            // Don't forget the complete now
            completionHandler(.success(()))
            
        }
        
    }
    
    public func waitForReadiness(_ completion: @escaping () -> Void) {
        initialize { _ in
            completion()
        }
    }
        
}
