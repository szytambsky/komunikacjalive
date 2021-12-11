//
//  VehicleDataTest.swift
//  komunikacjaliveTests
//
//  Created by Szymon Tamborski on 10/12/2021.
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

}
