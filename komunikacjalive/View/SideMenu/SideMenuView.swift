//
//  SideMenuView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    @Environment(\.colorScheme) var colorScheme
    @Binding var currentDate: String
    
    var body: some View {
        ZStack {
            if colorScheme == .dark {
                Color.black
                    .ignoresSafeArea()
            } else {
                Color.white
                    .ignoresSafeArea()
            }
            
            VStack(alignment: .leading) {
                SideMenuHeaderView(isShowing: $isShowing)
                
                ForEach(SideMenuViewOption.allCases, id: \.self) { option in
                    NavigationLink(destination: EmptyView()) {
                        EmptyView()
                    }
                    NavigationLink(
                        destination:
                            getDestination(forOption: option)
                            .navigationTitle("\(option.title)")
                            .navigationBarTitleDisplayMode(.inline),
                        label: {
                            SideMenuCell(option: option)
                        })
                }
                
                Spacer()
            }
            .padding(.top, 44)
        }
        .ignoresSafeArea()
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true), currentDate: .constant("brak daty"))
    }
}

extension SideMenuView {
    
    func getDestination(forOption option: SideMenuViewOption) -> AnyView {
        switch option {
        case .appinfo: return AnyView(SideMenuAppInfo(currentDate: $currentDate))
        case .privacypolicy: return AnyView(SideMenuPrivacyPolicy())
        }
    }
}
