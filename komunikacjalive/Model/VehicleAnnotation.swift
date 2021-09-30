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

class VehicleAnnotation: NSObject, Identifiable, MKAnnotation {
    
    var id = UUID()
    var lineName: String
    var vehicleNumber: String
    var brigade: String
    var latitude: Double
    var longitude: Double
    var oldLatitude: Double = 0.0
    var oldLongitude: Double = 0.0
    
    // inherit from MKAnnotation
    dynamic var coordinate: CLLocationCoordinate2D
    dynamic var title: String?
    dynamic var subtitle: String?
    
    var tint: Color {
        vehicleType == .bus ? .yellow : .red
    }
    
    var vehicleType: VehicleType {
        return lineName.count > 2 ? .bus : .tram
    }
    
    enum CodingKeys: String, CodingKey {
        //case id
        case coordinate = "coordinate"
        case lineName = "Lines"
        case vehicleNumber = "VehicleNumber"
        case brigade = "Brigade"
        case latitude = "Lat"
        case longitude = "Lon"
    }
    
    init(lineName: String, vehicleNumber: String, brigade: String, latitude: Double, longitude: Double, coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        self.coordinate = coordinate
        self.lineName = lineName
        self.vehicleNumber = vehicleNumber
        self.brigade = brigade
        self.latitude = latitude
        self.longitude = longitude
        self.title = lineName
        self.subtitle = vehicleNumber
    }
}

