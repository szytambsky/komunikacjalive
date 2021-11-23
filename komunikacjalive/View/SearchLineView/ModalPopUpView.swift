//
//  ModalPopUpView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct ModalPopUpView: View {
    @ObservedObject var fetcher: LineViewModel
    @Environment(\.colorScheme) var colorScheme
    
    //var lines: [VehicleAnnotation]
    //@Binding var showModalPopUp: Bool
    @State private var searchText = ""
    @Binding var showSearchLinesView: Bool
    
    @Binding var favouriteLines: [String]
    @State private var isFavouriteSection: Bool = false
    
    var filteredLines: [BusAndTram] {
        if searchText.count == 0 {
            return fetcher.busesAndTrams.sorted {$0.lineName.localizedStandardCompare($1.lineName) == .orderedAscending}.unique(map: { $0.lineName })
        } else {
            let arr = fetcher.busesAndTrams.sorted {$0.lineName.localizedStandardCompare($1.lineName) == .orderedAscending}.unique(map: { $0.lineName })
            return arr.filter({ $0.lineName.contains(searchText)})
        }
    }
    
    var body: some View {
        ZStack {
            colorScheme == .dark ? Color.black : Color.white
            
            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Button(action: {
                        showSearchLinesView = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 34))
                            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                    })
                    .padding(.horizontal)
                }
                
                ScrollView {
                    Spacer()
                    
                    SearchBar(searchText: $searchText)
                        .padding(.bottom)
                    
                    Spacer()
                    VStack {
                        if !favouriteLines.isEmpty {
                            VStack {
                                HStack(spacing: 2) {
                                    Text("Ulubione linie")
                                        .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                        .font(.headline)
                                        .frame(alignment: .leading)
                                    Spacer()
                                }
                                .padding(.leading)
                                
                                ZStack {
                                    ScrollView(showsIndicators: false, content: {
                                        SearchFavLinesView(favouriteLines: $favouriteLines)
                                    })
                                        .frame(height: 130)
                                    //.frame(maxHeight: CGFloat((favouriteLines.count % 5) * 65))
                                    .padding()
                                }
                            }
                        }
                        
                        HStack(spacing: 2) {
                            Text("Dostępne linie")
                                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                                .font(.headline)
                                .frame(alignment: .leading)
                            Spacer()
                        }
                        .padding(.leading)
                        
                        ScrollView(showsIndicators: true, content: {
                            SearchLinesView(lines: filteredLines, favouriteLines: $favouriteLines)
                        })
                            .padding()
                    }
                }
                
            }
            
        }
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ModalPopUpView(fetcher: LineViewModel(service: LineService()), showSearchLinesView: .constant(true), favouriteLines: .constant(exampleLinesString))
        }
        //showModalPopUp: .constant(true))
    }
}
