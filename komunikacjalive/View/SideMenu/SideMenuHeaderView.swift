//
//  SideMenuHeaderView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .trailing) {
            HStack {
                Text("Posbus")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.leading, 12)
                
                Spacer()
                
                Button(action: {
                    withAnimation(.spring()) {
                        isShowing.toggle()
                    }
                }, label: {
                    Image(systemName: "xmark")
                        .frame(width: 32, height: 32)
                        .padding()
                })
            }
        }
        .foregroundColor(Color(uiColor: .label))
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
