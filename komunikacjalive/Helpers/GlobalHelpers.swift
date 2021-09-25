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

extension Double {
    
    func truncate(places: Int) -> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

struct Constant {
    static let truncateValue = 6
}
