//
//  ContentView.swift
//  Permission Manager Example
//
//  Created by Christian Steffens on 08.06.22.
//

import SwiftUI
import SwiftyPermit

struct ContentView: View {
    
    let viewModel: ContentViewModel = .init()
    
    var body: some View {
        VStack(spacing: 16) {
 
            Button("Camera") {
                viewModel.requestCamera()
            }
    
            Button("Photo Library") {
                viewModel.requestPhotoLibrary()
            }
            
            Button("Local Network") {
                viewModel.requestLocalNetwork()
            }
                        
            Button("Tracking") {
                viewModel.requestTracking()
            }
            
            Button("User Notification") {
                viewModel.requestUserNotification()
            }

            Button("Location Permission 'whenInUse / reduced'") {
                viewModel.requestLocationWhenInUseReduced()
            }
            
            Button("Location Permission 'whenInUse / full'") {
                viewModel.requestLocationWhenInUseFull()
            }
            
            Button("Location Permission 'always / reduced'") {
                viewModel.requestLocationAlwaysReduced()
            }
            
            Button("Location Permission 'always / full'") {
                viewModel.requestLocationAlwaysFull()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
