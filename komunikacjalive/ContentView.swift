//
//  ContentView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var isNavigationBarHidden = true
    
    var body: some View {
        NavigationView {
            ZStack {
                Home(viewModel: LineViewModel())
                    .navigationBarTitle("", displayMode: .inline)
                    .navigationBarHidden(self.isNavigationBarHidden)
                    .onAppear(perform: {
                        self.isNavigationBarHidden = true
                    })
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
