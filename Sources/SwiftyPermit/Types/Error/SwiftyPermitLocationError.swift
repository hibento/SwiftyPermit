//
//  SwiftyPermitLocationError.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 10.10.21.
//  Copyright © 2021 hibento. All rights reserved.
//

import Foundation

public enum SwiftyPermitLocationError: Error {
    
    case accuracyDenied
    case variantDenied
    case purposeKeyIsMissing
        
}
