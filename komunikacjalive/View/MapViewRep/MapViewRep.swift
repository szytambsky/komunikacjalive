//
//  MapViewRep.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 16/09/2021.
//

import SwiftUI
import MapKit

struct MapViewRep: UIViewRepresentable {
    //@StateObject var mapData: MapViewModel
    
    // Thanks to Combine these ones are favouriteLines
    //@Binding var vehicles: [VehicleAnnotation]
    var busesAndTrams: [BusAndTram]
    var vehiclesDictionary: [String: VehicleAnnotation]
    
    //www.hackingwithswift.com/quick-start/swiftui/how-to-fix-cannot-assign-to-property-self-is-immutable
    @State private var oldCoordinates = [String: Double]()
    @State private var oldCoordinates2 = [String: Double]()
    
    func makeCoordinator() -> Coordinator {
        //return MapViewRep.Coordinator() //(self) if parent in Coordinator
        return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = MapViewModel.shared.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        return view
    }
   
    func updateUIView(_ view: MKMapView, context: Context) {
        print("updating")
        let oldAnnotations = view.annotations
        view.removeAnnotations(oldAnnotations)
        
        //if !busesAndTrams.isEmpty && !vehiclesDictionary.isEmpty {
        for key in vehiclesDictionary.keys {
            if let myAnnotation: VehicleAnnotation = vehiclesDictionary[key] {
                let ann = myAnnotation
                view.addAnnotation(ann)
                for model in busesAndTrams {
                    if model.vehicleNumber == key {
                        DispatchQueue.main.async {
                            updateLocationOnMap(model: model, myAnnotation: myAnnotation, mapView: view)
                            let oldCord = model.latitude
                            let oldCord2 = model.longitude
                            oldCoordinates[model.vehicleNumber] = oldCord
                            oldCoordinates2[model.vehicleNumber] = oldCord2
                        }
                    }
                }
            }
        }
    }
    
    func updateLocationOnMap(model: BusAndTram, myAnnotation: VehicleAnnotation, mapView: MKMapView) {
        //let oldLocation = CLLocationCoordinate2D(latitude: model.oldLatitude, longitude: model.oldLongitude)
        if let oldCoordinates = oldCoordinates[model.vehicleNumber], let oldCoordinates2 = oldCoordinates2[model.vehicleNumber] {
            let oldLocation = CLLocationCoordinate2D(latitude: oldCoordinates, longitude: oldCoordinates2)
            let newLocation = CLLocationCoordinate2D(latitude: model.latitude , longitude: model.longitude)
            let getAngle = self.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)

            myAnnotation.coordinate = newLocation
            let annotationView = mapView.view(for: myAnnotation)
            annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(getAngle))
            // brakuje tego ze w przypadku wzorca oldlat i oldlong to index - 1 ktory rosnie +1 po kazdym punkcie jak zachowac stare lat i lon???
            //busesAndTrams = []
            //vehiclesDictionary = [:]
        }
    }
    
    func angleFromCoordinate(firstCoordinate: CLLocationCoordinate2D, secondCoordinate: CLLocationCoordinate2D) -> Double {
        let deltaLongitude: Double = secondCoordinate.longitude - firstCoordinate.longitude
        let deltaLatitude: Double = secondCoordinate.latitude - firstCoordinate.latitude
        let angle = (Double.pi * 0.5) - atan(deltaLatitude / deltaLongitude)
        
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
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewRep

        init(_ parent: MapViewRep) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            
//            if annotation.isKind(of: MKUserLocation.self) {
//                return nil
//            } else {
//                let identifier: String = "CustomViewAnnotation"
//
//                var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
//
//                if let annotationView = annotView {
//                    return annotationView
//                } else {
//
//                    annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
//                    annotView?.image = UIImage(named: "autobus")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//                    let size = CGSize(width: 32, height: 32)
//                    annotView?.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
//                        annotView?.image!.draw(in: CGRect(origin: .zero, size: size))
//                    })
//                    return annotView
//                }
//
//            }
            
            if annotation is MKUserLocation {
                return nil
            } else {
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "vehicle_annotation")
                //annotationView.canShowCallout = true
                annotationView.image = UIImage(named: "autobus")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                let size = CGSize(width: 32, height: 32)
                annotationView.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
                    annotationView.image!.draw(in: CGRect(origin: .zero, size: size))
                })
                return annotationView
            }
            
        }
    }
}


//    func updateLocationsOnMap(myAnnotations: [VehicleAnnotation], mapView: MKMapView) {
//        // showAnnotations for capturing all of Custom Annotation on the screen
//        //mapView.showAnnotations(myAnnotations, animated: true)
//        for annotation in mapView.annotations {
//            if let objectAnn = annotation as? VehicleAnnotation {
//                var structObject = BusAndTram(lineName: objectAnn.lineName, latitude: objectAnn.latitude, longitude: objectAnn.longitude, oldLatitude: objectAnn.oldLatitude, oldLongitude: objectAnn.oldLongitude)
//
//                let newLocation = CLLocationCoordinate2D(latitude: structObject.latitude, longitude: structObject.longitude)
//                print("debug: lat:\(structObject.latitude), lon:\(structObject.longitude) and oldlat: \(structObject.oldLatitude), oldlon: \(structObject.oldLongitude) ")
//                let getAngle = angleFromCoordinate(firstCoordinate: CLLocationCoordinate2D(latitude: structObject.oldLatitude, longitude: structObject.oldLongitude), secondCoordinate: newLocation)
//                let rotateViewAnn = mapView.view(for: objectAnn)
//                rotateViewAnn?.transform = CGAffineTransform(rotationAngle: CGFloat(getAngle))
//
//                structObject.oldLatitude = structObject.latitude
//                structObject.oldLongitude = structObject.latitude
//            } else {
//                print("thats not Vehicle Annotation")
//            }
//        }
//
//    }
