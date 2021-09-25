//
//  MapView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import MapKit
import SwiftUI
import Combine

//struct MapView: View {
//    @EnvironmentObject private var viewModel: MapViewModel
//    @ObservedObject private var fetcher = LineViewModel()
//    
//    @State private var showSearchLinesView = false
//    
//    //@State private var favLines = [VehicleAnnotation]()
//    var region = MKCoordinateRegion(
//        center: MapDetails.startingLocation,
//        span: MapDetails.defaultSpan)
//    
//    let screen = UIScreen.main.bounds
//    
//    var body: some View {
//        ZStack {
//            Map(coordinateRegion: $viewModel.region,
//                interactionModes: .all,
//                showsUserLocation: true,
//                annotationItems: fetcher.favouriteLines) { item in
//                MapAnnotation(coordinate: item.coordinate) {
//                    ZStack {
//                        Circle()
//                            .strokeBorder(Color.black, lineWidth: 4)
//                            .background(Circle().foregroundColor(item.tint))
//                            .frame(width: 44, height: 44)
//                        Text("\(item.lineName)")
//                            .bold()
//                    }
//                    .foregroundColor(.white)
//                }
//            }
//            .accentColor(Color(.systemPink))
//            .onAppear {
//                //viewModel.checkIfLocationServicesIsEnabled()
//            }
//
//            VStack {
//                Spacer()
//                
//                HStack {
//                    Spacer()
//                    
//                    Button(action: {
//                        showSearchLinesView = true
//                    }, label: {
//                        Image(systemName: "magnifyingglass")
//                            .padding()
//                            .font(.system(size: 25))
//                            .background(Color.graySearchBackground.opacity(0.5))
//                            .clipShape(Circle())
//                            .foregroundColor(.white)
//                            .padding(.trailing, 16)
//                    })
//                    .fullScreenCover(isPresented: $showSearchLinesView, content: {
//                        ModalPopUpView(fetcher: fetcher, searchShowLinesView: $showSearchLinesView, favouriteLines: $fetcher.favouriteLinesName)// $favouriteLines)
//                    })
//                }
//                
//                Spacer()
//                
//                Button(action: {
//                    withAnimation {
//                        viewModel.region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
//                    }
//                }, label: {
//                    Text("Zoom in")
//                        .frame(width: screen.width/3)
//                        .font(.system(size: 22, weight: .bold, design: .default))
//                        .padding()
//                        .background(Color.green)
//                        .clipShape(Capsule())
//                })
//                .padding(.bottom, 40)
//                .foregroundColor(.white)
//            }
//            
//            if fetcher.isLoading {
//                LoadingView()
//            }
//        }
//    }
//    
//}

//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.black
//                .edgesIgnoringSafeArea(.all)
//            
//            MapView()
//                .edgesIgnoringSafeArea(.all)
//                .environmentObject(MapViewModel())
//        }
//    }
//}
