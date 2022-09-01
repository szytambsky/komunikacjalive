//
//  SearchLinesView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct SearchLinesView: View {
    var lines: [BusAndTram]
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
                ForEach(lines, id: \.self) { line in
                    StandardLineView(line: line, favouriteLines: $favouriteLines) {
                        self.favouriteLines.append(line.lineName)
                        self.favouriteLines = Array(Set(favouriteLines))
                        print(favouriteLines)
                    }
                }
            }
            
            Spacer()
        }
    }
    
}

struct SearchLinesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            SearchLinesView(lines: MockData.allExampleAnnotations, favouriteLines: .constant(MockData.exampleLinesString))
        }
    }
}
