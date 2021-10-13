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
    //@StateObject var viewModel = MapViewModel()

    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnboardingContainerView()
            } else {
                ContentView()
                    //.environmentObject(MapViewModel.shared)
                    //.environmentObject(viewModel)
            }
        }
    }
}
