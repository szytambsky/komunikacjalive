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

struct BusAndTram: Codable, Hashable, Equatable {
    var lineName: String = ""
    var vehicleNumber: String
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var oldLatitude: Double = 0.0
    var oldLongitude: Double = 0.0
    var time: String = "Nie otrzymano danych w dniu dzisiejszym"
    
    enum CodingKeys: String, CodingKey {
        case lineName = "Lines"
        case latitude = "Lat"
        case longitude = "Lon"
        case vehicleNumber = "VehicleNumber"
        case time = "Time"
    }
}
