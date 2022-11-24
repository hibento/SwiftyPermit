//
//  AVAuthorizationStatus.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import AVFoundation

extension AVAuthorizationStatus: CustomStringConvertible {

    public var description: String {
        
        switch self {
            
        case .notDetermined:
            return "notDetermined"
            
        case .restricted:
            return "restricted"
            
        case .denied:
            return "denied"
            
        case .authorized:
            return "authorized"
            
        @unknown default:
            return rawValue.description
            
        }
        
    }
    
}
