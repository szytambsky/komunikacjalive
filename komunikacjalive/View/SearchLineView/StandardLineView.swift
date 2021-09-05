//
//  StandardLineView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct StandardLineView: View {
    var line: VehicleAnnotation
    
    var body: some View {
        ZStack {
            // MARK: - TO DO: change colors if pressed
            Button(action: {
                //
            }, label: {
                Circle()
                    .strokeBorder(Color.red, lineWidth: 4)
                    .background(Circle().foregroundColor(.white))
//                    .frame(width: 75, height: 75)
            })
            
            Text(line.lineName)
                .bold()
                .font(.system(size: 24))
                .foregroundColor(.black)
        }
    }
}

struct StandardLineView_Previews: PreviewProvider {
    static var previews: some View {
        StandardLineView(line: exampleAnnotation2)
    }
}
