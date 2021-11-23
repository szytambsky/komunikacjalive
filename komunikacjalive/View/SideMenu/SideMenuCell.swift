//
//  SideMenuCell.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/10/2021.
//

import SwiftUI

struct SideMenuCell: View {
    @Environment(\.colorScheme) var colorScheme
    let option: SideMenuViewOption
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: option.imageName)
                .frame(width: 24, height: 24)
            Text(option.title)
                .font(.system(size: 15, weight: .bold))
            
            Spacer()
        }
        .padding()
        .foregroundColor(colorScheme == .dark ? .white : .black)
    }
}

struct SideMenuCell_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuCell(option: SideMenuViewOption.author)
    }
}
