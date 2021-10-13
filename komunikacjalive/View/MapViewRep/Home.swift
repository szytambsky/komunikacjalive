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
    @State private var showingSideMenu = false
    
    @State private var showSearchLinesView = false
    
    let screen = UIScreen.main.bounds
    
    @State var counter = 0
    let timer = Timer.publish(every: 15, tolerance: 0.5, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            if showingSideMenu {
                SideMenuView(isShowing: $showingSideMenu)
                    .padding(.top, 44)
                    .ignoresSafeArea()
            }
            
            MapViewRep(busesAndTrams: fetcher.busesAndTrams, vehiclesDictionary: fetcher.vehicleDictionary)
                .environmentObject(mapData)
                .ignoresSafeArea(.all, edges: .all)
                .onReceive(timer, perform: { time in
                    fetcher.fetchLines()
                })
                .offset(x: showingSideMenu ? 300 : 0, y: showingSideMenu ? 66 : 0)
                .opacity(showingSideMenu ? 0.25 : 1)
                //.cornerRadius(showingSideMenu ? 16 : 0)
                .scaleEffect(showingSideMenu ? 0.9 : 1)
                .shadow(color: showingSideMenu ? .black : .clear, radius: 20, x: 0, y: 0)
                .disabled(showingSideMenu) // dont interact with view
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            showingSideMenu.toggle()
                        }
                    }, label: {
                        ZStack {
                            Color.white.opacity(0.44)
                                .frame(width: 64, height: 64)
                                .foregroundColor(.white.opacity(0.44))
                                .clipShape(Circle())
                                .padding()
                                
                            Image(systemName: "text.justify")
                                .font(.title2)
                                .padding()
                                .background(Color.graySearchBackground.opacity(0.55))
                                .clipShape(Circle())
                                .foregroundColor(.white)
                        }
                        .shadow(color: .gray, radius: 2, x: 0, y: 2)
                    })
                    
                    Spacer()
                }
                .padding(.top, 32)
                
                Spacer()
                
                RightPanelButtons(fetcher: fetcher, showSearchLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)
                    .environmentObject(mapData)
                    .padding(.trailing, 16)
                    .opacity(showingSideMenu ? 0 : 1)
                    .disabled(showingSideMenu ? true : false)
                
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
            self.showingSideMenu = false
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
                        //mapData.centerUserLocation()
                        mapData.centerViewOnUserLocation()
                    }, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                            .foregroundColor(Color.graySearchBackground.opacity(0.55))
                            .shadow(color: .gray, radius: 2, x: 0, y: 2)
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
                            .shadow(color: .white, radius: 2, x: 0, y: 2)
                    })
                }
            }
        }
    }
}
