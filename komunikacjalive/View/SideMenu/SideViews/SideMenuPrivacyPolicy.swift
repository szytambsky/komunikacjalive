//
//  PrivacyPolicy.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 02/12/2021.
//

import SwiftUI

struct SideMenuPrivacyPolicy: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color.white
                    .ignoresSafeArea()
            }
            
            List {
                ForEach(PrivacyPolicyContent.allCases, id: \.self) { item in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(item.title)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .font(.title)
                        Text(item.caption)
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                            .font(.caption)
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding()
                
            }.listRowBackground(colorScheme == .dark ? Color.black : Color.white)
        }
        .ignoresSafeArea()
    }
}

struct PrivacyPolicy_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuPrivacyPolicy()
    }
}

enum PrivacyPolicyContent: Int, CaseIterable, Equatable {
    case privacypolicy
    case info
    
    var title: String {
        switch self {
        case .privacypolicy: return "Polityka Prywatności"
        case .info: return "info"
        }
    }
    
    var caption: String {
        switch self {
        case .privacypolicy: return "tekst tekst tekst tekst tekst tekst tekst tekst tekst tekst tekst tekst "
        case .info: return "teskt tekst tekst teksttekst tekst tekst tekst tekst tekst tekst tekst tekst tekst tekst"
        }
    }
}
