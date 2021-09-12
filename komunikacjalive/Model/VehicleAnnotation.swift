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

struct VehiclesLocationResult: Codable {
    var result: [VehicleAnnotation]
}

struct VehicleAnnotation: Codable, Identifiable, Hashable {
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
    
    enum CodingKeys: String, CodingKey {
        //case id
        case lineName = "Lines"
        case vehicleNumber = "VehicleNumber"
        case brigade = "Brigade"
        case latitude = "Lat"
        case longitude = "Lon"
    }
    
    // Custom decoding initializer
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//
//        id = try values.decode(UUID.self, forKey: .id)
//        lineName = try values.decode(String.self, forKey: .lineName)
//        vehicleNumber = try values.decode(String.self, forKey: .vehicleNumber)
//        brigade = try values.decode(String.self, forKey: .brigade)
//        latitude = try values.decode(Double.self, forKey: .latitude)
//        longitude = try values.decode(Double.self, forKey: .longitude)
//    }
}

