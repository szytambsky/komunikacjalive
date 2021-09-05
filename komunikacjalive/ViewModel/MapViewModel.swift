//
//  MapViewModel.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 02/09/2021.
//

import Foundation
import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 52.237049, longitude: 21.01753)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    //@Published var lines: [VehicleAnnotation] = [exampleAnnotation1, exampleAnnotation2, exampleAnnotation3, exampleAnnotation4]
    @Published var lines: [VehicleAnnotation] = [exampleAnnotation1, exampleAnnotation2]
    
    @Published var region = MKCoordinateRegion(
        center: MapDetails.startingLocation,
        span: MapDetails.defaultSpan)
    
    // nil => user can turn off location services for whole phone
    var locationManager: CLLocationManager?
    
    static let shared = MapViewModel()
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        } else {
            print("Show an alert letting user now location services for whole phone are off")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location is restricted")
            case .denied:
                print("You have denied this app location permission. Change it in settings")
            case .authorizedAlways, .authorizedWhenInUse:
                if let sourceCoordinates = locationManager.location?.coordinate  {
                    region = MKCoordinateRegion(
                        center: sourceCoordinates,
                        span: MapDetails.defaultSpan)
                } // else { return }
            @unknown default:
                break
        }
    }
    
    // The system calls this method when the app creates the related object’s CLLocationManager instance, and when the app’s authorization status changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
