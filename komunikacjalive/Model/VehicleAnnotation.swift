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

struct VehicleAnnotation: Identifiable {
    var id = UUID()
    var lineName: String
    var vehicleNumber: String
    var brigade: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var tint: Color {
        vehicleType == .bus ? .yellow : .red
    }
    
    var vehicleType: VehicleType {
        return lineName.count > 2 ? .bus : .tram
    }
}

//struct VehicleAnnotation3: Identifiable {
//    var id = UUID().uuidString
//    var lines: String
//    var vehicleNumber: String
//    var brigade: String
//    
//    var coordinate: CLLocationCoordinate2D
//    
//    var vehicleType: VehicleType {
//        return lines.count > 2 ? .bus : .tram
//    }
//}

//    var coordinate: CLLocationCoordinate2D {
//        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }

//    var latitude: Double
//    var longitude: Double
//    var tint: Color {
//        vehicleType == .bus ? .yellow : .red


