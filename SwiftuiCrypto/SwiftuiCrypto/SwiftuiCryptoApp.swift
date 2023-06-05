//
//  SwiftuiCryptoApp.swift
//  SwiftuiCrypto
//
//  Created by Cuong Pham on 19/05/2023.
//

import SwiftUI

@main
struct SwiftuiCryptoApp: App {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var showLaunchView: Bool = true
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
        
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor(Color.theme.accent)
        ]
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    if #available(iOS 16.0, *) {
                        HomeView()
                            .toolbar(.hidden)
                    } else {
                        HomeView()
                            .navigationBarHidden(true)
                    }
                }
                .navigationViewStyle(StackNavigationViewStyle())
                .environmentObject(viewModel)
                
                ZStack {
                    if showLaunchView{
                        LaunchView(showLaunchView: $showLaunchView)
                            .transition(.scale)
                    }
                }
                .zIndex(2.0)
            }
            
        }
    }
}
