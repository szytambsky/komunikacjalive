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
    static let regionInMeters = CLLocationDistance(2000)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var mapView = MKMapView()
    @Published var isAuthorized = false
    @Published var mapType: MKMapType = .standard
    
    @Published var region: MKCoordinateRegion!
    
    // nil => user can turn off location services for whole phone
    var locationManager: CLLocationManager?
    
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
    }
    
    //// The system calls this method when the app creates the related object’s CLLocationManager instance, and when the app’s authorization status changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .denied:
            isAuthorized = false
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            centerViewOnUserLocation()
        default:
            break
        }
    }
    
    ////  Set visable rect around user current location
    func centerViewOnUserLocation() {
        if let location = locationManager?.location?.coordinate {
            region = MKCoordinateRegion.init(center: location, latitudinalMeters: MapDetails.regionInMeters, longitudinalMeters: MapDetails.regionInMeters)
            DispatchQueue.main.async {
                self.mapView.setRegion(self.region, animated: true)
                self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    ////  Getting user last location region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: MapDetails.regionInMeters, longitudinalMeters: MapDetails.regionInMeters)

        // Updating map & Smooth animations
        DispatchQueue.main.async {
            self.mapView.setRegion(self.region, animated: true)
            self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
        }
    }
    
}
