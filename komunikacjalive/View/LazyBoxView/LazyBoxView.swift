//
//  LazyBoxView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 09/07/2022.
//

import Foundation
import SwiftUI

struct LazyBoxView<T: View>: View {
    
    var view: () -> T

    var body: some View {
        self.view()
    }
    
}
