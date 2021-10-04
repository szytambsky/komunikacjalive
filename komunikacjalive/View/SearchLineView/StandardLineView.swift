//
//  StandardLineView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct StandardLineView: View {
    var line: BusAndTram?
    @Binding var favouriteLines: [String]
    
    var body: some View {
        ZStack {
            if let line = line {
                Button(action: {
                    favouriteLines.append(line.lineName)
                    favouriteLines = Array(Set(favouriteLines))
                    print(favouriteLines)
                }, label: {
                    Circle()
                        .strokeBorder(Color.red, lineWidth: 4)
                        .background(Circle().foregroundColor(.white))
                        .frame(width: 65, height: 65)
                        .padding(4)
                })
                
                Text(line.lineName)
                    .bold()
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    .animation(.default)
            }
        }
    }
}

struct StandardLineView_Previews: PreviewProvider {
    static var previews: some View {
        StandardLineView(line: busexample1, favouriteLines: .constant(exampleLinesString))
    }
}
