//
//  SwiftyPermitError.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

public enum SwiftyPermitError: Error {
    
    case `deinit`
    case notInitialized
    case system(Error)
    case deniedSystem
    case deniedUser
    case restricted
    case notDetermined
    
    case plistEntryMissing(SwiftyPermitPListEntry)
    case location(SwiftyPermitLocationError)
    
}
