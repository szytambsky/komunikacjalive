//
//  OnboardingContainerView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 07/10/2021.
//

import SwiftUI

//ignroe safe area https://serialcoder.dev/text-tutorials/swiftui/ignoring-safe-area-in-swiftui/
struct OnboardingContainerView: View {
    @Binding var isOnboarding: Bool
    
    var body: some View {
        TabView {
            ForEach(onboardingFeatures) { feature in
                OnboardingContentView(feature: feature, isOnboarding: $isOnboarding)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .ignoresSafeArea()
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.graySearchText)
        }
        .onDisappear {
            UIPageControl.appearance().currentPageIndicatorTintColor = nil
            UIPageControl.appearance().pageIndicatorTintColor = nil
        }
    }
    
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView(isOnboarding: .constant(true))
    }
}
