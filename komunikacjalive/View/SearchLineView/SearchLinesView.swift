//
//  SearchLinesView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import SwiftUI

struct SearchLinesView: View {
    var lines: [VehicleAnnotation]
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: columns,spacing: 2) {
                ForEach(0..<lines.count) { lineIndex in
                    let line = lines[lineIndex]
                    StandardLineView(line: line)
                        .frame(height: 60)
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
            
            SearchLinesView(lines: allExampleAnnotations)
        }
    }
}
