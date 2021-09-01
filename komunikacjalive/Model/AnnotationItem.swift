//
//  AnnotationItem.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 01/09/2021.
//

import Foundation
import MapKit
import SwiftUI

enum VehicleType {
    case bus
    case tram
}

struct AnnotationItem: Identifiable {
    var id = UUID().uuidString
    var vehicleType: VehicleType
    var number: Int
    var coordinate: CLLocationCoordinate2D
    
    var tint: Color {
        vehicleType == .bus ? .yellow : .red
    }
}
