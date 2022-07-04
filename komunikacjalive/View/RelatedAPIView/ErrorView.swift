//
//  ErrorView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/09/2021.
//

import SwiftUI

struct ErrorView: View {
    @ObservedObject var viewModel: LineViewModel
    
    var body: some View {
        VStack {
            Text("Error view")
                .font(.system(size: 18))
            
            Text(viewModel.errorMessage ?? "")
            
            Button(action: {
                viewModel.fetchLines()
            }, label: {
                Text("Try Again")
            })
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(viewModel: LineViewModel())
    }
}
