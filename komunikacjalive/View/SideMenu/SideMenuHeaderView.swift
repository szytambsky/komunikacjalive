//
//  SideMenuHeaderView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuHeaderView: View {
    @Binding var isShowing: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            HStack {
                Spacer()
//                Button(action: {
//                    withAnimation(.spring()) {
//                        isShowing.toggle()
//                    }
//                }, label: {
//                    Image(systemName: "xmark")
//                        .frame(width: 32, height: 32)
//                        .foregroundColor(.black)
//                        .padding()
//                })
            }
        }
        .foregroundColor(.black)
    }
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowing: .constant(true))
    }
}
