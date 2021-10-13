//
//  SideMenuView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.white]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
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
        case .moreinfo: return AnyView(Text(option.title))
        case .author: return AnyView(Text(option.title))
        }
    }
}
