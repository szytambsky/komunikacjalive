//
//  komunikacjaliveApp.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import SwiftUI

@main
struct komunikacjaliveApp: App {
    @AppStorage("isOnboarding") var isOnboarding = true
    @State private var isSplashScreenOnScreen = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if isOnboarding {
                    OnboardingContainerView(isOnboarding: $isOnboarding)
                } else if isOnboarding == false && isSplashScreenOnScreen == false {
                    ContentView()
                }
                
                SplashScreen(isSplashScreenOn: $isSplashScreenOnScreen)
            }
        }
    }
}
