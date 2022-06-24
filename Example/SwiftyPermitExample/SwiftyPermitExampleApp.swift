//
//  SwiftyPermitExampleApp.swift
//  Permission Manager Example
//
//  Created by Christian Steffens on 08.06.22.
//

import SwiftUI
import Combine
import SwiftyPermit

@main
struct SwiftyPermitExampleApp: App {
    
    var subscriptions = Set<AnyCancellable>()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    
    init() {
        
        SwiftyPermit.shared
            .didChange
            .sink { permissionChanged in
                print(permissionChanged)
            }
            .store(in: &subscriptions)
        
    }
    
}
