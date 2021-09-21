//
//  MapViewRep.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 16/09/2021.
//

import SwiftUI
import MapKit

struct MapViewRep: UIViewRepresentable {
    @EnvironmentObject var mapData: MapViewModel
    @Binding var vehicles: [VehicleAnnotation]
    
    func makeCoordinator() -> Coordinator {
        return MapViewRep.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }
   
    func updateUIView(_ view: MKMapView, context: Context) {
        view.addAnnotations(vehicles)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            } else {
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "vehicle_annotation")
                //annotationView.canShowCallout = true
                annotationView.image = UIImage(systemName: "bus")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                let size = CGSize(width: 32, height: 32)
                annotationView.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
                    annotationView.image!.draw(in: CGRect(origin: .zero, size: size))
                })
                return annotationView
            }
            
        }
    }
}
