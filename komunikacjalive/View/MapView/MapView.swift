//
//  MapView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import MapKit
import SwiftUI

struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $viewModel.region, showsUserLocation: true)
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }

            VStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        viewModel.region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    }
                }, label: {
                    Text("Zoom in")
                        //.frame(width: screen.width/3)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .padding()
                        .background(Color.green)
                        .clipShape(Capsule())
                })
            }
            .padding(.bottom, 24)
            .foregroundColor(.white)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            MapView()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
