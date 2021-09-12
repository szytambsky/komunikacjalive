//
//  LoadingView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 12/09/2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
            Text("Loading...")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
