//
//  OnboardingContentView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/10/2021.
//

import SwiftUI

struct OnboardingContentView: View {
    @AppStorage("isOnboarding") var isOnboarding: Bool?
    var feature: Feature
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            VStack {
                Spacer()

                Image(feature.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: screen.width / 1.5, height: screen.width / 1.5)
                
                Spacer()
                
                VStack(spacing: 20) {
                    Text(feature.title)
                        .font(.system(size: 24, weight: .bold))
                    Text(feature.subtitle)
                        .font(.callout)
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    isOnboarding = false
                }, label: {
                    Text("Zaczynam")
                        .padding()
                        .background(
                            Capsule().strokeBorder(Color.white, lineWidth: 1.5)
                                .frame(width: 120)
                        )
                })
                
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContentView(feature: onboardingFeatures[0])
    }
}
