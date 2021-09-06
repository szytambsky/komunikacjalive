//
//  ContentView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import SwiftUI

struct ContentView: View {
    //@State private var showModalPopUp = false
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            MapView()
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
                .environmentObject(MapViewModel())
        }
    }
}
