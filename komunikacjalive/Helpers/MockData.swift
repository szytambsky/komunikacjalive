//
//  MockData.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 02/09/2021.
//

import Foundation
import SwiftUI
import MapKit


// MARK: - MOCK DATA
class MockData {
    static let exampleAnnotation1 = VehicleAnnotation(lineName: "7", vehicleNumber: "5555", brigade: "7", latitude: 52.235031, longitude: 21.01876, coordinate: CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876), title: "7", subtitle: "5555")
    static let exampleAnnotation2 = VehicleAnnotation(lineName: "520", vehicleNumber: "4444", brigade: "4", latitude: 52.234031, longitude: 21.01976, coordinate: CLLocationCoordinate2D(latitude: 52.234031, longitude: 21.01976), title: "520", subtitle: "4444")

    static let busexample1 = BusAndTram(lineName: "151", vehicleNumber: "5666", latitude: 52.234031, longitude: 21.0187, oldLatitude: 52.23403, oldLongitude: 21.01876)
    static let busexample2 = BusAndTram(lineName: "24", vehicleNumber: "4545", latitude: 52.23031, longitude: 21.187, oldLatitude: 52.2403, oldLongitude: 21.0876)
    static let busexample3 = BusAndTram(lineName: "9", vehicleNumber: "4549", latitude: 52.23032, longitude: 21.182, oldLatitude: 52.2402, oldLongitude: 21.0872)

    static let allExampleAnnotations = [busexample1, busexample2, busexample3]

    static let allExampleAnnotationsOther = [exampleAnnotation1, exampleAnnotation2]
    static let exampleLinesString = ["151", "520", "525", "168", "111", "131", "117"]

}

struct MockFunctions {
    static func errorState() -> LineViewModel {
        let viewModel = LineViewModel()
        viewModel.errorMessage = APIError.url(URLError.init(.notConnectedToInternet)).localizedDescription
        return viewModel
    }
    
    static func successState() -> LineViewModel {
        let viewModel = LineViewModel()
        //viewModel.lines = []//exampleAnnotation1, exampleAnnotation2]
        return viewModel
    }
}

let onboardingFeatures = [
    Feature(title: "Zacznij już dziś", subtitle: "Miej swoje autobusy zawsze na wyciągniecie ręki", image: "bus-front"),
    Feature(title: "Bądź na czas", subtitle: "Dostęp ułatwi Ci proszuanie się po mieście", image: "bus-inside"),
    Feature(title: "Rozpocznij z nami", subtitle: "Najwygodniejsze narzędzie czeka", image: "bus-middle")
]
