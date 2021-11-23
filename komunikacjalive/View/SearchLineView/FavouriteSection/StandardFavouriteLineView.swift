//
//  StandardFavouriteLineView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 10/11/2021.
//

import SwiftUI

struct StandardFavouriteLineView: View {
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
                    //.strokeBorder(Color.red, lineWidth: 4)
                    .background(Circle().foregroundColor(.white))
                    .frame(width: 65, height: 65)
                    .padding(4)
            })
            
            Text(favouriteLine)
                .bold()
                .font(.system(size: 24))
                .foregroundColor(.black)
                //.animation(.default)
        }
    }
}

struct StandardFavouriteLineView_Previews: PreviewProvider {
    static var previews: some View {
        StandardFavouriteLineView(favouriteLine: "151", favouriteLines: .constant(exampleLinesString), action: {})
    }
}
