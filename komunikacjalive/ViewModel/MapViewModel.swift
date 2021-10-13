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
    @Published var permissionDenied = false
    @Published var mapType: MKMapType = .standard
    
    @Published var region: MKCoordinateRegion!//(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    // nil => user can turn off location services for whole phone
    var locationManager: CLLocationManager?
    
    //static let shared = MapViewModel()
    var oldLocations = [CLLocationCoordinate2D]()
    var newLocations = [CLLocationCoordinate2D]()
    
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
        } else {
            print("Show an alert letting user now location services for whole phone are off")
        }
    }
    
    // The system calls this method when the app creates the related object’s CLLocationManager instance, and when the app’s authorization status changes.
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        //checkLocationAuthorization()
        switch manager.authorizationStatus {
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
            case .restricted:
                print("Location is restricted")
            case .denied:
                print("You have denied this app location permission. Change it in settings")
                permissionDenied.toggle()
            case .authorizedAlways, .authorizedWhenInUse:
                //manager.requestLocation()
                centerViewOnUserLocation()
            @unknown default:
                break
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager?.location?.coordinate {
            region = MKCoordinateRegion.init(center: location, latitudinalMeters: MapDetails.regionInMeters, longitudinalMeters: MapDetails.regionInMeters)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // Getting user Region
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        self.region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: MapDetails.regionInMeters, longitudinalMeters: MapDetails.regionInMeters)

        // Updating map & Smooth animations
        self.mapView.setRegion(self.region, animated: true)
        self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)
    }
    
}
