//
//  ContentView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Home()
                .edgesIgnoringSafeArea(.all)
//                .overlay (
//                    Color.clear // Or any view or color // I put clear here because I prefer to put a blur in this case. This modifier and the material it contains are optional.
//                    .edgesIgnoringSafeArea(.top)
//                    .frame(height: 0)
//                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ContentView()
                //.environmentObject(MapViewModel())
        }
    }
}
