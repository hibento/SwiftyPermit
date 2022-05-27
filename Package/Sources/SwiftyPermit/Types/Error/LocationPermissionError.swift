//
//  LocationPermissionError.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

public enum LocationPermissionError: Error {
    
    case accuracyDenied
    case variantDenied
    case purposeKeyIsMissing
        
}
