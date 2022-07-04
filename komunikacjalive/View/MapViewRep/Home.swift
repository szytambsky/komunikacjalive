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
    @ObservedObject var viewModel: LineViewModel
    @State private var showingSideMenu = false
    
    @State private var showSearchLinesView = false
    
    private let screen = UIScreen.main.bounds
    
    var body: some View {
        ZStack {
            if showingSideMenu {
                SideMenuView(isShowing: $showingSideMenu, currentDate: $viewModel.currentDate, availableBusesAndTrams: $viewModel.busesAndTrams)
            }
            
            MapViewRep(busesAndTrams: viewModel.busesAndTrams, vehicleDictionary: viewModel.vehicleDictionary)
                .cornerRadius(showingSideMenu ? 20 : 10)
                .environmentObject(mapData)
                .onReceive(viewModel.$time, perform: { time in
                    viewModel.fetchLines()
                })
                .offset(x: showingSideMenu ? (screen.width / 1.52) : 0, y: showingSideMenu ? (screen.height / 9) : 0)
                .opacity(showingSideMenu ? 0.25 : 1)
                .scaleEffect(showingSideMenu ? 0.9 : 1)
                .shadow(color: showingSideMenu ? .black : .clear, radius: 20, x: 0, y: 0)
                .disabled(showingSideMenu)
                .onAppear {
                    viewModel.startTimer()
                }
                .onDisappear {
                    viewModel.stopTimer()
                }
            
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
                            .shadow(color: colorScheme == .dark ? .black : .gray, radius: 1, x: 0, y: 1)
                    })
                    Spacer()
                }
                .padding(.top, 64)
                .padding(.leading, 12)
                .opacity(showingSideMenu ? 0 : 1)
                .disabled(showingSideMenu)
                
                Spacer()
                
                RightPanelButtons(fetcher: viewModel, showSearchLinesView: $showSearchLinesView, favouriteLines: $viewModel.favouriteLinesName)
                    .environmentObject(mapData)
                    .padding(.trailing, 16)
                    .opacity(showingSideMenu ? 0 : 1)
                    .disabled(showingSideMenu ? true : false)
                
                Spacer()
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            mapData.checkIfLocationServicesIsEnabled()
            self.showingSideMenu = false
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            Home(viewModel: LineViewModel())
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
    @State private var goToSettings = false
    
    var body: some View {
        HStack {
            Spacer()
            
            ZStack {
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
                            .shadow(color: colorScheme == .dark ? .black : .gray, radius: 1, x: 0, y: 1)
                    })
                    .fullScreenCover(isPresented: $showSearchLinesView, content: {
                        ModalPopUpView(fetcher: fetcher, showSearchLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)
                    })
                    
                    Button(action: {
                        if mapData.isAuthorized {
                            mapData.centerViewOnUserLocation()
                        } else {
                            goToSettings = true
                        }
                    }, label: {
                        Image(systemName: "location.fill")
                            .font(.title2)
                            .padding()
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: colorScheme == .dark ? .black : .gray, radius: 1, x: 0, y: 1)
                    })
                    .alert(isPresented: $goToSettings) {
                        Alert(title: Text("Lokalizacja niedostępna"), message: Text("Odrzuciłeś możliwość ustaleniapołożenia urządzenia. Aby skorzystać zmień to w ustawieniach"), primaryButton:.default(Text("Idź do ustawień")) {

                        UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options:[:], completionHandler: nil)
                        }, secondaryButton: .destructive(Text("Anuluj")))}
                    
                    Button(action: {
                        mapData.updateMapType()
                    }, label: {
                        Image(systemName: mapData.mapType == .standard ? "network" : "map")
                            .font(.title2)
                            .padding()
                            .background(colorScheme == .dark ? Color.graySearchBackground.opacity(0.55) : .white)
                            .clipShape(Circle())
                            .foregroundColor(colorScheme == .dark ? .white : Color.graySearchBackground.opacity(0.55))
                            .shadow(color: colorScheme == .dark ? .black : .gray, radius: 1, x: 0, y: 1)
                    })
                }
            }
        }
    }
}
