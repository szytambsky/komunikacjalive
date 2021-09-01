//
//  MapView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import MapKit
import SwiftUI

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 52.237049, longitude: 21.01753),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region)
            
            VStack {
                Spacer()
                
                Button(action: {
                    withAnimation {
                        region.span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                    }
                }, label: {
                    Text("Zoom in")
                        .frame(width: screen.width/3)
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
