//
//  MapView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import MapKit
import SwiftUI

struct MapView: View {
    @EnvironmentObject private var viewModel: MapViewModel
    
    @State private var navBarHidden = true
    
    let screen = UIScreen.main.bounds
    
    var body: some View {
        NavigationView {
            ZStack {
                Map(coordinateRegion: $viewModel.region,
                    interactionModes: .all,
                    showsUserLocation: true,
                    annotationItems: viewModel.lines) { item in
                    MapAnnotation(coordinate: item.coordinate) {
                        ZStack {
                            Circle()
                                .strokeBorder(Color.black, lineWidth: 4)
                                .background(Circle().foregroundColor(item.tint))
                                .frame(width: 44, height: 44)
                            Text("\(item.lineName)")
                                .bold()
                        }
                        .foregroundColor(.white)
                    }
                }
                .accentColor(Color(.systemPink))
                .onAppear {
                    viewModel.checkIfLocationServicesIsEnabled()
                }
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        NavigationLink(
                            destination: ModalPopUpView(lines: viewModel.lines, navBarHidden: $navBarHidden),
                            label: {
                                Image(systemName: "magnifyingglass")
                                    .padding()
                                    .font(.system(size: 25))
                                    .background(Color.graySearchBackground.opacity(0.5))
                                    .clipShape(Circle())
                                    .foregroundColor(.white)
                                    .padding(.trailing, 16)
                            })
                            .navigationBarHidden(navBarHidden)
                            .navigationBarTitle("", displayMode: .large)
                            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
                                // every time we come from background to app we have to hide nav bar again
                                self.navBarHidden = true
                            })
                            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification), perform: { _ in
                                // for performance we set to false when we go to backgorund
                                self.navBarHidden = false
                            })
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        withAnimation {
                            viewModel.region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
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
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                
                MapView()
            }
        }
    }
}
