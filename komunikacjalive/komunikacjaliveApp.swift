//
//  komunikacjaliveApp.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import SwiftUI

@main
struct komunikacjaliveApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(MapViewModel.shared)
        }
    }
}
