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
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .ignoresSafeArea()
            
            VStack {
                Spacer()

                Image(feature.image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screen.width / 1.5, height: screen.width / 1.5)
                    .shadow(color: .gray, radius: 3, x: 0, y: 3)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Text(feature.title)
                        .font(.headline)
                    Text(feature.subtitle)
                        .font(.callout)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .foregroundColor(Color(uiColor: .label))
                .padding()
                
                Spacer()
                
                Button(action: {
                    isOnboarding = false
                }, label: {
                    Text("Zaczynam")
                        .frame(width: screen.width/3)
                        .font(.headline)
                        .padding()
                        .background(Color(uiColor: .label))
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                        .foregroundColor(Color(uiColor: .systemBackground))
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
