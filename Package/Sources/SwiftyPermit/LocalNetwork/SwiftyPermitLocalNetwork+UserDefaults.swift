//
//  SwiftyPermitNetwork+UserDefaults.swift
//  SwiftyPermit
//
//  Created by Christian Steffens on 08.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import Foundation

extension SwiftyPermit.LocalNetwork {
    
    /// Returns true, if the local network permission was requested at least
    /// once by the user. This is important, as the local network permission
    /// can't be checked without requesting it.
    public static var permitRequestedOnce: Bool {
        get {
            return UserDefaults.standard.bool(forKey: permitRequestedOnceKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: permitRequestedOnceKey)
        }
    }
    
    private static let permitRequestedOnceKey: String = "de.hibento.SwiftyPermit.localNetwork.permitRequestedOnce"
    
}
