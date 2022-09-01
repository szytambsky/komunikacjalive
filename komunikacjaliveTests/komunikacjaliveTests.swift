//
//  komunikacjaliveTests.swift
//  komunikacjaliveTests
//
//  Created by Szymon Tamborski on 17/12/2021.
//

import XCTest
import MapKit
import SwiftUI
@testable import komunikacjalive

class komunikacjaliveTests: XCTestCase {
    
    var sut: MapViewRep!
    
    override func setUp() {
        super.setUp()
        
        self.sut = MapViewRep(busesAndTrams: MockData.allExampleAnnotations, vehicleDictionary: ["5555": MockData.exampleAnnotation1])
    }

    func test_IfCustomAnnotationIsInheritedFromMKAnnotationView() throws {
        let exampleAnnotation = VehicleAnnotation(lineName: "7", vehicleNumber: "5555", brigade: "7", latitude: 52.235031, longitude: 21.01876, coordinate: CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876), title: "7", subtitle: "5555")
        
        let annotationView = AnnotationView(annotation: exampleAnnotation, reuseIdentifier: "exampleIdentifier")
        
        XCTAssertTrue((annotationView as Any) is MKAnnotationView)
    }
    
    func test_IfAngleFromCoordinateIsZero() throws {
        let oldLocation = CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876)
        let newLocation = CLLocationCoordinate2D(latitude: 52.235031, longitude: 21.01876)
        
        let getAngle = self.sut.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)
        
        XCTAssertTrue(getAngle == 0.0)
    }
    
    func test_IfAvailableCountOfBusesOrTramsAreTrue() throws {
        let availableBuses = MockData.allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count > 2 }).count
        let availableTrams = MockData.allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count <= 2 }).count
        let availableAirplanes = MockData.allExampleAnnotations.unique(map: { $0.lineName }).filter({ $0.lineName.count > 5 }).count
        
        XCTAssertTrue(availableTrams == 2)
        XCTAssertTrue(availableBuses == 1)
        XCTAssertTrue(availableAirplanes == 0)
    }
    
    func test_IfRectAfterRotatingIsCorrectlyBounded() throws {
    
    }

}
