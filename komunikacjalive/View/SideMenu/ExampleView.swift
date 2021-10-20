//
//  ExampleView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 13/10/2021.
//

import SwiftUI

struct ExampleView: View {
    var body: some View {
        ZStack {
            Color.red
                .edgesIgnoringSafeArea(.all)
             Text("PRZYKLADOWY WIDOK")
                .foregroundColor(.white)
                .font(.system(size: 20, weight: .bold))
        }
    }
}

struct ExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView()
    }
}
