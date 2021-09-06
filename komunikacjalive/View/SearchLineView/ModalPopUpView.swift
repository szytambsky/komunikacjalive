//
//  ModalPopUpView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct ModalPopUpView: View {
    var lines: [VehicleAnnotation]
    //@Binding var showModalPopUp: Bool
    @State private var searchText = ""
    @Binding var searchShowLinesView: Bool
    
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
                }
                
                Spacer()
                
                SearchBar(searchText: $searchText)
                
                Spacer()
                
                ScrollView(showsIndicators: false, content: {
                    SearchLinesView(lines: lines)
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
            
            ModalPopUpView(lines: allExampleAnnotations, searchShowLinesView: .constant(true))
        }//showModalPopUp: .constant(true))
    }
}
