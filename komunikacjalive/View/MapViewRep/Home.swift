//
//  Home.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 16/09/2021.
//

import SwiftUI
import MapKit

struct Home: View {
    @StateObject var mapData = MapViewModel()
    @ObservedObject var fetcher = LineViewModel()
    
    @State private var showSearchLinesView = false
    
    let screen = UIScreen.main.bounds
    
    @State var counter = 0
    let timer = Timer.publish(every: 15, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            // usunac podwojne busesAndTrams i vehiclesDictionary
            MapViewRep(busesAndTrams: fetcher.favouriteBusesAndTram, vehiclesDictionary: fetcher.vehicleDictionary)
                //.environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .onReceive(timer, perform: { time in
                    fetcher.fetchLines()
                })
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    VStack(spacing: 20) {
                        Button(action: {
                            showSearchLinesView = true
                        }, label: {
                            Image(systemName: "magnifyingglass")
                                .padding()
                                .font(.system(size: 25))
                                .background(Color.graySearchBackground.opacity(0.55))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        })
                        .fullScreenCover(isPresented: $showSearchLinesView, content: {
                            ModalPopUpView(fetcher: fetcher, searchShowLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)// $favouriteLines)
                    })
                        Button(action: {
                            mapData.centerUserLocation()
                        }, label: {
                            Image(systemName: "location.fill")
                                .font(.title2)
                                .padding()
                                .background(Color.graySearchBackground.opacity(0.55))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        })
                        
                        
                        Button(action: {
                            mapData.updateMapType()
                        }, label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding()
                                .background(Color.graySearchBackground.opacity(0.55))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        })
                        
                        Button(action: {
                            fetcher.fetchLines()
                        }, label: {
                            Image(systemName: mapData.mapType == .standard ? "network" : "map")
                                .font(.title2)
                                .padding()
                                .background(Color.graySearchBackground.opacity(0.95))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        })
                        
                    }
                }
                .padding(.trailing, 16)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        mapData.region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
                    }
                }, label: {
                    Text("Zoom in")
                        .frame(width: screen.width/3)
                        .font(.system(size: 22, weight: .bold, design: .default))
                        .padding()
                        .background(Color.green)
                        .clipShape(Capsule())
                })
                .padding(.bottom, 40)
                .foregroundColor(.white)
            }
            
//            if fetcher.isLoading {
//                LoadingView()
//            }
        }
        .onAppear(perform: {
            mapData.checkIfLocationServicesIsEnabled()
        })
        .alert(isPresented: $mapData.permissionDenied, content: {
            Alert(title: Text("Permission Denied"), message: Text("You have denied this app location permission. Change it in settings"), dismissButton: .default(Text("Go to Settings"), action: {
                // Redirect user to settings
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }))
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Home()
                .edgesIgnoringSafeArea(.all)
        }
    }
}
