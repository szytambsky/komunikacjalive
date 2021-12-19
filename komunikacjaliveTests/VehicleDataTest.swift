//
//  VehicleDataTest.swift
//  komunikacjaliveTests
//
//  Created by Szymon Tamborski on 17/12/2021.
//

import XCTest
import MapKit
import SwiftUI
@testable import komunikacjalive

class VehicleDataTest: XCTestCase {

    func testIfCustomAnnotationInheritFromMKAnnotationView() throws {
        let exampleAnnotation = VehicleAnnotation(lineName: "7", vehicleNumber: "5555", brigade: "7", latitude: 52.235031, longitude: 21.01876, coordinate: CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876), title: "7", subtitle: "5555")
        
        let annotationView = AnnotationView(annotation: exampleAnnotation, reuseIdentifier: "exampleIdentifier")
        XCTAssertTrue((annotationView as Any) is MKAnnotationView)
    }
    
    func testGetAngleValueReturned() throws {
        let oldLocation = CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876)
        let newLocation = CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876)
        
        let getAngle = self.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)
        
        XCTAssertTrue(getAngle == 0.0)
    }

    func angleFromCoordinate(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> Double {
        let deltaLongitude: Double = secondCoordinate.longitude - firstCoordinate.longitude
        let deltaLatitude: Double = secondCoordinate.latitude - firstCoordinate.latitude
        let angle = -(Double.pi * 0.5) - atan(deltaLatitude / deltaLongitude)
        
        if (deltaLongitude > 0) {
            return angle
        } else if (deltaLongitude < 0) {
            return angle + Double.pi
        } else if (deltaLatitude < 0) {
            return Double.pi
        } else {
            return 0.0
        }
    }
    
    func testAvailableCountOfBusesOrTram() throws {
        let availableBuses = allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count > 2 }).count
        let availableTrams = allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count <= 2 }).count
        let availableAirplanes = allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count > 5 }).count
        XCTAssertTrue(availableTrams == 2)
        XCTAssertTrue(availableBuses == 1)
        XCTAssertTrue(availableAirplanes == 0)
    }
}
