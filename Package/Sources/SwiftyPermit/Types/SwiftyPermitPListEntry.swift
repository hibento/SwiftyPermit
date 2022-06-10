//
//  SwiftyPermitPListEntry.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 31.08.20.
//  Copyright © 2020 hibento. All rights reserved.
//

import Foundation

public enum SwiftyPermitPListEntry {
    
    case keyValue(String)
    case arrayValue(array: String, value: String)
    case dictionaryKey(dictionary: String, key: String)
    
}
