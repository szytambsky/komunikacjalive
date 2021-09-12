//
//  ErrorView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/09/2021.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var fetcher: LineViewModel
    
    var body: some View {
        VStack {
            Text("Error view")
                .font(.system(size: 18))
            
            Text(fetcher.errorMessage ?? "")
            
            Button(action: {
                fetcher.fetchLines()
            }, label: {
                Text("Try Again")
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(fetcher: LineViewModel())
    }
}
