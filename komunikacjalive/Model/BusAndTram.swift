//
//  Bus.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 22/09/2021.
//

import SwiftUI

struct BusAndTramResult: Codable {
    var result: [BusAndTram]
}

struct BusAndTram: Codable, Hashable {
    var lineName: String = ""
    var vehicleNumber: String
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var oldLatitude: Double = 0.0
    var oldLongitude: Double = 0.0
    //var coordinate: CLLocationCoordinate2D
    
//    init(lineName: String, latitude: Double, longitude: Double) {//, coordinate: CLLocationCoordinate2D) {
//        self.lineName = lineName
//        self.latitude = latitude
//        self.longitude = longitude
//        //self.coordinate = coordinate
//    }
    
    enum CodingKeys: String, CodingKey {
        case lineName = "Lines"
        case latitude = "Lat"
        case longitude = "Lon"
        case vehicleNumber = "VehicleNumber"
    }
}
