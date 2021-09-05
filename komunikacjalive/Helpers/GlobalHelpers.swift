//
//  GlobalHelpers.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 03/09/2021.
//

import Foundation
import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
