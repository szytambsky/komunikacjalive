//
//  StandardFavouriteLineView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 10/11/2021.
//

import SwiftUI

struct StandardFavouriteLineView: View {
    @Environment(\.colorScheme) var colorScheme
    var favouriteLine: String
    @Binding var favouriteLines: [String]
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            Button(action: {
                action()
            }, label: {
                Circle()
                    .strokeBorder(favouriteLine.count > 2 ? Color(UIColor(named: "busCol")!):Color(UIColor(named: "tramCol")!), lineWidth: 3)
                    .background(Circle().foregroundColor(.white))
                    .frame(width: 65, height: 65)
                    .shadow(color: colorScheme == .dark ? .black : .gray, radius: 1, x: 0, y: 1)
                    .padding(4)
            })
            
            Text(favouriteLine)
                .bold()
                .font(.system(size: 24))
                .foregroundColor(.black)
        }
    }
}

struct StandardFavouriteLineView_Previews: PreviewProvider {
    static var previews: some View {
        StandardFavouriteLineView(favouriteLine: "151", favouriteLines: .constant(MockData.exampleLinesString), action: {})
    }
}
