//
//  PermissionError.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

public enum PermissionError: Error {
    
    case `deinit`
    case notInitialized
    case system(Error)
    case deniedSystem
    case deniedUser
    case restricted
    case notDetermined
    
    case infoPListEntryMissing(PermissionInfoPListEntry)
    case location(LocationPermissionError)
    
}
