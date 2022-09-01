//
//  SearchFavLinesView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 10/11/2021.
//

import SwiftUI

struct SearchFavLinesView: View {
    @Binding var favouriteLines: [String]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 2) {
                ForEach(0..<favouriteLines.count, id: \.self) { index in
                    StandardFavouriteLineView(favouriteLine: favouriteLines[index], favouriteLines: $favouriteLines) {
                        self.favouriteLines.remove(at: index)
                        print(favouriteLines)
                    }
                }
            }
            
            Spacer()
        }
    }
}

struct SearchFavLinesView_Previews: PreviewProvider {
    static var previews: some View {
        SearchFavLinesView(favouriteLines: .constant(MockData.exampleLinesString))
    }
}
