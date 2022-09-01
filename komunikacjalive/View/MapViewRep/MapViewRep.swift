//
//  MapViewRep.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 16/09/2021.
//

import SwiftUI
import MapKit

struct MapViewRep: UIViewRepresentable {
    @EnvironmentObject private var mapData: MapViewModel
    
    var busesAndTrams: [BusAndTram]
    var vehicleDictionary: [String: VehicleAnnotation]
    
    @State private var oldCoordinates = [String: Double]()
    @State private var oldCoordinates2 = [String: Double]()
    
    func makeCoordinator() -> Coordinator {
        return MapViewRep.Coordinator()
        //return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        view.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: "cluster")
        return view
    }
   
    func updateUIView(_ view: MKMapView, context: Context) {
        let oldAnnotations = view.annotations
        view.removeAnnotations(oldAnnotations)

        for key in vehicleDictionary.keys {
            if let myAnnotation: VehicleAnnotation = vehicleDictionary[key] {
                view.addAnnotation(myAnnotation)
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
        if let oldCoordinates = oldCoordinates[model.vehicleNumber], let oldCoordinates2 = oldCoordinates2[model.vehicleNumber] {
            let oldLocation = CLLocationCoordinate2D(latitude: oldCoordinates, longitude: oldCoordinates2)
            let newLocation = CLLocationCoordinate2D(latitude: model.latitude , longitude: model.longitude)
            let getAngle = self.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)

            myAnnotation.coordinate = newLocation
            //let tintColor = myAnnotation.vehicleType == .bus ? "busCol" : "tramCol"
            let annotationView = mapView.view(for: myAnnotation) as? AnnotationView
            if getAngle == 0.0 {
                annotationView?.image = nil
            } else {
                let imageBeforeRotation = UIImage(named: "bus-arrow")?.withTintColor(UIColor.label).withRenderingMode(.alwaysTemplate)
                //annotationView?.image
                let imageAfterRotation = imageBeforeRotation?.rotate(radians: Float(CGFloat(getAngle)))
                annotationView?.image = imageAfterRotation
            }

            /* 0.25 is a proportion of declared in Coordinator class the
             width and height of vehicle image to original image size */
            
            annotationView?.frame = CGRect(x: 0, y: 0, width: (annotationView?.bounds.size.width)! * 0.25, height: (annotationView?.bounds.size.height)! * 0.25)
        }
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
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        let vehicleWidthSize = 64
        let vehicleHeightSize = 64
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            } else if let cluster = annotation as? MKClusterAnnotation {
                var view = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? ClusterView
                if view == nil {
                    view = ClusterView(annotation: cluster, reuseIdentifier: "cluster")
                }
                return view
            } else if let vehicle = annotation as? VehicleAnnotation {
                let identifier: String = "marker"
                
                if vehicle.vehicleType == .bus {
                    return customizeVehicleAnnotationView(annotation: vehicle, identifier: identifier, mapView: mapView, colorName: "busCol")
                } else if vehicle.vehicleType == .tram {
                    return customizeVehicleAnnotationView(annotation: vehicle, identifier: identifier, mapView: mapView, colorName: "tramCol")
                }
            }
            
            return nil
        }
        
        func customizeVehicleAnnotationView(annotation: VehicleAnnotation, identifier: String, mapView: MKMapView, colorName: String) -> MKAnnotationView? {
            var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
            annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
//            let pinIcon = UIImage(named: "bus-arrow")?.withTintColor(UIColor.label).withRenderingMode(.alwaysTemplate)
//            annotView?.image = pinIcon
            annotView?.frame = CGRect(x: 0, y: 0, width: vehicleWidthSize, height: vehicleHeightSize)
            let annotationLabel = UILabel()
            annotView?.addSubview(annotationLabel)
            annotationLabel.translatesAutoresizingMaskIntoConstraints = false
            annotationLabel.widthAnchor.constraint(equalToConstant: 31).isActive = true
            annotationLabel.heightAnchor.constraint(equalToConstant: 31).isActive = true
            annotationLabel.centerXAnchor.constraint(equalTo: annotView!.centerXAnchor).isActive = true
            annotationLabel.centerYAnchor.constraint(equalTo: annotView!.centerYAnchor).isActive = true
            annotationLabel.backgroundColor = .blue
            annotationLabel.numberOfLines = 0
            annotationLabel.textAlignment = .center
            annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            annotationLabel.text = annotation.title!
            annotationLabel.textColor = .white
            annotationLabel.backgroundColor = UIColor(named: colorName)
            annotationLabel.layer.cornerRadius = 15.5
            annotationLabel.layer.masksToBounds = true
            annotationLabel.layer.borderWidth = 2
            annotationLabel.layer.borderColor = UIColor.label.cgColor
            
            annotView?.clusteringIdentifier = "bus"
            //annotView?.rightCalloutAccessoryView = annotView?.btnInfo
            annotView?.canShowCallout = true
            
            return annotView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotationTitle = view.annotation?.title {
                print("User tapped on annotation with title: \(annotationTitle!)")
            }
        }
    }
}
