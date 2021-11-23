//
//  OnboardingContentView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/10/2021.
//

import SwiftUI

struct OnboardingContentView: View {
    var feature: Feature
    @Binding var isOnboarding: Bool
    @Environment(\.colorScheme) var colorScheme
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            //LinearGradient(gradient: Gradient(colors: [Color.white, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing)
            colorScheme == .dark ? Color.black : Color.white
            
            VStack {
                Spacer()

                Image(feature.image)
                    .resizable()
                    .scaledToFill()
                    //.clipShape(Circle())
                    .frame(width: screen.width / 1.5, height: screen.width / 1.5)
                    .shadow(color: .gray, radius: 3, x: 0, y: 3)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text(feature.title)
                        .font(.headline)
                    Text(feature.subtitle)
                        .font(.callout)
                }
                //.multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .padding()
                
                Spacer()
                
                Button(action: {
                    isOnboarding = false
                }, label: {
                    Text("Zaczynam")
                        .frame(width: screen.width/3)
                        .font(.headline)
                        .padding()
                        .background(colorScheme == .dark ? Color.white : Color.black)
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                })
                
                Spacer()
            }
        }
        .ignoresSafeArea()
    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContentView(feature: onboardingFeatures[0], isOnboarding: .constant(true))
    }
}
