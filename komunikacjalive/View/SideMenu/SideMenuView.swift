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
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black : Color.white
            
            VStack {
                SideMenuHeaderView(isShowing: $isShowing)
                
                ForEach(SideMenuViewOption.allCases, id: \.self) { option in
                    NavigationLink(
                        destination: getDestination(forOption: option),
                        label: {
                            SideMenuCell(option: option)
                        })
                }
                
                Spacer()
            }
            .padding(.top, 44)
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowing: .constant(true))
    }
}

extension SideMenuView {
    
    func getDestination(forOption option: SideMenuViewOption) -> AnyView {
        switch option {
        case .moreinfo: return AnyView(ExampleView())//AnyView(Text(option.title))
        case .author: return AnyView(Text(option.title))
        }
    }
}
