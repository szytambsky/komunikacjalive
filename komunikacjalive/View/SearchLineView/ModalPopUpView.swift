//
//  ModalPopUpView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct ModalPopUpView: View {
    @ObservedObject var fetcher: LineViewModel
    
    //var lines: [VehicleAnnotation]
    //@Binding var showModalPopUp: Bool
    @State private var searchText = ""
    @Binding var searchShowLinesView: Bool
    
    @Binding var favouriteLines: [String]
    
    var filteredLines: [VehicleAnnotation] {
        if searchText.count == 0 {
            return fetcher.lines
        } else {
            return fetcher.lines.filter({ $0.lineName.contains(searchText)})
        }
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
                HStack {
                    Spacer()
                    Button(action: {
                        searchShowLinesView = false
                    }, label: {
                        Image(systemName: "xmark.circle")
                            .font(.system(size: 34))
                            .foregroundColor(.white)
                    })
                    .padding(.horizontal)
                }
                
                Spacer()
                
                SearchBar(searchText: $searchText)
                
                Spacer()
                
                ScrollView(showsIndicators: false, content: {
                    SearchLinesView(lines: filteredLines, favouriteLines: $favouriteLines)
                })
                .padding()
            }
            
        }
    }
}

struct ModalPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ModalPopUpView(fetcher: LineViewModel(service: LineService()), searchShowLinesView: .constant(true), favouriteLines: .constant(exampleLinesString))
        }//showModalPopUp: .constant(true))
    }
}
