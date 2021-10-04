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
            MapViewRep(busesAndTrams: fetcher.busesAndTrams, vehiclesDictionary: fetcher.vehicleDictionary)
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .onReceive(timer, perform: { time in
                    fetcher.fetchLines()
                })
                //.overlay(Color.clear)
            
            
            VStack {
                HStack {
                    Button(action: {
                        mapData.centerUserLocation()
                    }, label: {
                        ZStack {
                            Color.green
                                .frame(width: 64, height: 64)
                                .foregroundColor(.green)
                                .clipShape(Circle())
                                .padding()
                                
                            Image(systemName: "text.justify")
                                .font(.title2)
                                .padding()
                                .background(Color.graySearchBackground.opacity(0.55))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                    })
                    
                    Spacer()
                }
                .padding(.top, 38)
                .padding(.leading, 12)
                
                Spacer()
                
                RightPanelButtons(fetcher: fetcher, showSearchLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)
                    .environmentObject(mapData)
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
            
            if fetcher.isLoading {
                LoadingView()
            }
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

struct RightPanelButtons: View {
    @EnvironmentObject private var mapData: MapViewModel
    @ObservedObject var fetcher: LineViewModel
    @Binding var showSearchLinesView: Bool
    @Binding var favouriteLines: [String]
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
//                Capsule()
//                    .foregroundColor(.green.opacity(0.15))
//                    .frame(width: 70, height: 220)
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
                        ModalPopUpView(fetcher: fetcher, showSearchLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)// $favouriteLines)
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
                }
            }
        }
    }
}
