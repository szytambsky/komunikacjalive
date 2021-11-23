//
//  Home.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 16/09/2021.
//

import SwiftUI
import MapKit

struct Home: View {
    @Environment(\.colorScheme) var colorScheme
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
            }
            
            MapViewRep(busesAndTrams: fetcher.busesAndTrams, vehicleDictionary: fetcher.vehicleDictionary)
                .cornerRadius(showingSideMenu ? 20 : 10)
                .environmentObject(mapData)
                .onReceive(timer, perform: { time in
                    fetcher.fetchLines()
                })
                .offset(x: showingSideMenu ? (screen.width / 1.3) : 0, y: showingSideMenu ? (screen.height / 6) : 0)
                .opacity(showingSideMenu ? 0.25 : 1)
                .scaleEffect(showingSideMenu ? 0.9 : 1)
                .shadow(color: showingSideMenu ? .black : .clear, radius: 20, x: 0, y: 0)
                //.customCornerRadius(24, corners: [.topLeft, .topRight])
                .disabled(showingSideMenu)
            
            VStack {
                HStack {
                    Button(action: {
                        withAnimation(.spring()) {
                            showingSideMenu.toggle()
                        }
                    }, label: {
                        Image(systemName: "text.justify")
                            .font(.title2)
                            .padding()
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                    })
                    Spacer()
                }
                .padding(.top, 64)
                .padding(.leading, 12)
                .opacity(showingSideMenu ? 0 : 1)
                .disabled(showingSideMenu)
                
                Spacer()
                
                RightPanelButtons(fetcher: fetcher, showSearchLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)
                    .environmentObject(mapData)
                    .padding(.trailing, 16)
                    .opacity(showingSideMenu ? 0 : 1)
                    .disabled(showingSideMenu ? true : false)
                
                Spacer()
            }
            
            if fetcher.isLoading {
                LoadingView()
            }
        }
        //// https://developer.apple.com/documentation/swiftui/view/edgesignoringsafearea(_:)
        .edgesIgnoringSafeArea(.all)
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
    @Environment(\.colorScheme) var colorScheme
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
                            .font(.title2)
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
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
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                    })
                    
                    Button(action: {
                        mapData.updateMapType()
                    }, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding()
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: .gray, radius: 1, x: 0, y: 1)
                    })
                }
            }
        }
    }
}
