//
//  AVMediaType.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation
import AVKit

extension AVMediaType: CustomStringConvertible {
    
    public var description: String {
        return rawValue.debugDescription
    }
    
}
