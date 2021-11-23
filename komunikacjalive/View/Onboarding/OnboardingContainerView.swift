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
    @Environment(\.colorScheme) var colorScheme
    
    let onboardingFeatures = [
        Feature(title: "Zacznij już dziś", subtitle: "Miej swoje ulubione autobusy zawsze na wyciągniecie ręki", image: "ob-subway"),
        Feature(title: "Bądź na czas", subtitle: "Dostęp ułatwi Ci proszuanie się po mieście", image: "ob-travel"),
        Feature(title: "Rozpocznij z nami", subtitle: "Najwygodniejsze narzędzie czeka", image: "ob-adventure")
    ]
    
    var body: some View {
        TabView {
            ForEach(onboardingFeatures) { feature in
                OnboardingContentView(feature: feature, isOnboarding: $isOnboarding)
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(named: "lightBlue")
            UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.graySearchText)
        }
        .onDisappear {
            UIPageControl.appearance().currentPageIndicatorTintColor = nil
            UIPageControl.appearance().pageIndicatorTintColor = nil
        }
        .ignoresSafeArea()
    }
    
}

struct OnboardingContainerView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingContainerView(isOnboarding: .constant(true))
    }
}
