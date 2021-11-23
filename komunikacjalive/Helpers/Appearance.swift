//
//  Appearance.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 18/11/2021.
//

import Foundation
import SwiftUI

/*
 Appearance values stored as computed values in order to allow
 for multiple trait collection conformance.
 */

extension Color {
    static let graySearchBackground = Color("gray_search_background")
    static let graySearchText = Color("gray_search_text")
    static let lightGraySearchBackground = Color("light_gray_search_background")
}

struct Appearance {
    static let graySearchBackground = Color("gray_search_background")
    static let graySearchText = Color("gray_search_text")
    static let lightGraySearchBackground = Color("light_gray_search_background")
    
    static var alternateColor: Color {
        return Color(red: 180 / 255, green: 176 / 255, blue: 250 / 255)
    }
    
    static var backgroundColor: Color {
        return Color(red: 102 / 255, green: 96 / 255, blue: 246 / 255)
    }

    static var textColor: Color {
        return Color(red: 63 / 255, green: 60 / 255, blue: 84 / 255)
    }
    
    static var busColor: Color {
        return Color(red: 102 / 255, green: 96 / 255, blue: 246 / 255)
    }
    
    static var tramColor: Color {
        return Color(red: 247 / 255, green: 116 / 255, blue: 139 / 255)
    }
    
    static func setNavigationAppearance() {
        let navigationAppearance = UINavigationBarAppearance()
        navigationAppearance.configureWithOpaqueBackground()
        navigationAppearance.backgroundColor = UIColor(backgroundColor)
        navigationAppearance.titleTextAttributes = [.foregroundColor: UIColor(textColor)]
        navigationAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(textColor)]
        
        UINavigationBar.appearance().standardAppearance = navigationAppearance
        UINavigationBar.appearance().compactAppearance = navigationAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationAppearance
        UINavigationBar.appearance().tintColor = UIColor(alternateColor)
    }
}
