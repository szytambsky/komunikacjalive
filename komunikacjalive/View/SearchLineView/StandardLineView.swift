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
    
    var action: () -> Void
    
    var body: some View {
        ZStack {
            if let line = line {
                Button(action: {
                    action()
                }, label: {
                    Circle()
                        .strokeBorder(line.lineName.count > 2 ? Color(UIColor(named: "busCol")!) :Color(UIColor(named: "tramCol")!), lineWidth: 4)
                        .background(Circle().foregroundColor(.white))
                        .frame(width: 65, height: 65)
                        .padding(4)
                })
                
                Text(line.lineName)
                    .bold()
                    .font(.system(size: 24))
                    .foregroundColor(.black)
                    //.animation(.default)
            }
            
            
        }
    }
}

struct StandardLineView_Previews: PreviewProvider {
    static var previews: some View {
        StandardLineView(line: busexample1, favouriteLines: .constant(exampleLinesString)) {
            //
        }
    }
}
