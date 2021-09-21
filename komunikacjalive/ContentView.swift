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
