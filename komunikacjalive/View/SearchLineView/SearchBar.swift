//
//  SearchBar.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    
    @State private var isEditing = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.graySearchBackground
                .frame(width: 270, height: 46)
                .cornerRadius(8)
            
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.graySearchText)
                    .padding(.leading, 10)
                
                TextField("Wyszukaj lini", text: $searchText)
                    .padding(12)
                    .background(Color.graySearchBackground)
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .onTapGesture(perform: {
                        isEditing = true
                    })
                    .animation(.default)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color.graySearchText)
                            .frame(width: 35, height: 35)
                    })
                    .padding(.trailing, 18)
                }
                
                if isEditing {
                    Button(action: {
                        searchText = ""
                        isEditing = false
                        hideKeyboard()
                    }, label: {
                        Text("Cancel")
                            .foregroundColor(.white)
                    })
                    .padding(.trailing, 10)
                    .animation(.default)
                    .transition(.move(edge: .trailing))
                }
            }
        }
        .padding(.horizontal)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            SearchBar(searchText: .constant(""))
        }
    }
}
