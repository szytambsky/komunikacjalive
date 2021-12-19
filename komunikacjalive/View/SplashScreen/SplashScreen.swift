//
//  SplashScreen.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 26/11/2021.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(\.colorScheme) var colorScheme
    
    @State private var animationFinished: Bool = false
    @Binding var isSplashScreenOn: Bool
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack {
                LottieView(filename: colorScheme == .dark ? "splash_screen_dark" : "splash_screen_light")
            }
        }
        .opacity(animationFinished ? 0 : 1)
        .onAppear {
            // lottie file time to complete = 3.0s so we can close it after 3.3s easily
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.3) {
                withAnimation(.easeInOut(duration: 0.3)) {
                    animationFinished = true
                    isSplashScreenOn = false
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen(isSplashScreenOn: .constant(true))
    }
}
