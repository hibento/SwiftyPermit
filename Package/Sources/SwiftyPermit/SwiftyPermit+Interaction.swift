//
//  SwiftyPermit+Interaction.swift
//  Permission-Manager
//
//  Created by Christian Steffens on 27.05.22.
//  Copyright © 2022 hibento. All rights reserved.
//

import UIKit

extension SwiftyPermit {
    
    func openAppSettings() {
        
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            logger.error("SettingsUrl is not set")
            return
        }
        
        UIApplication.shared.open(url)
        
    }
    
}
