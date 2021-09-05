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
    @Binding var navBarHidden: Bool
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 8) {
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
            
            ModalPopUpView(lines: allExampleAnnotations, navBarHidden: .constant(true))
        }//showModalPopUp: .constant(true))
    }
}
