//
//  PermissionChanged.swift
//  
//
//  Created by Christian Steffens on 08.06.2022.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

public struct PermissionChanged: CustomDebugStringConvertible {
    
    // MARK: - Variables
    
    let wasGranted: Bool?
    let isGranted: Bool?
    
    let permission: Permission
    
    // MARK: - Properties
    
    public var debugDescription: String {
        return "PermissionState \(permission.debugDescription): \(wasGranted?.description ?? "?") → \(isGranted?.description ?? "?")"
    }
    
    public var permissionDidChange: Bool {
        
        if let wasGranted = wasGranted,
           let isGranted = isGranted {
            return wasGranted != isGranted
        } else if wasGranted != nil || isGranted != nil {
            return true
        } else {
            return false
        }
        
    }
    
    // MARK: - Initializer
    
    init(permission: Permission,
         wasGranted: Bool?,
         isGranted: Bool?) {
               
        self.permission = permission
        self.wasGranted = wasGranted
        self.isGranted = isGranted

    }
    
}
