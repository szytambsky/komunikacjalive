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
    
    //www.hackingwithswift.com/quick-start/swiftui/how-to-fix-cannot-assign-to-property-self-is-immutable
    @State private var oldCoordinates = [String: Double]()
    @State private var oldCoordinates2 = [String: Double]()
    
    func makeCoordinator() -> Coordinator {
        return MapViewRep.Coordinator()
        //return Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let view = mapData.mapView
        //let view = MapViewModel.shared.mapView
        view.showsUserLocation = true
        view.delegate = context.coordinator
        // If we declare an MKAnnotationView in other class file and override MKAnnotation we have to register it here not in view for
        //view.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        view.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: "cluster")
        return view
    }
   
    func updateUIView(_ view: MKMapView, context: Context) {
        let oldAnnotations = view.annotations
        view.removeAnnotations(oldAnnotations)
        //view.addAnnotations(Array(vehicleDictionary.values))

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
            let annotationView = mapView.view(for: myAnnotation) as? AnnotationView
            let imageBeforeRotation = annotationView?.image
            let imageAfterRotation = imageBeforeRotation?.rotate(radians: Float(CGFloat(getAngle)))
            annotationView?.image = imageAfterRotation
            annotationView?.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
            //annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(getAngle))
            //annotationView?.btnInfo?.transform = CGAffineTransform(rotationAngle: CGFloat(getAngle))
            //annotationView?.image?.ciImage?.transformed(by: CGAffineTransform(rotationAngle: CGFloat(getAngle)))
            //busesAndTrams = []
            //vehiclesDictionary = [:]
        }
    }
    
    func boundingRectAfterRotatingRect(rect: CGRect, toAngle radians: CGFloat) -> CGRect {
        let xfrm = CGAffineTransform(rotationAngle: radians)
        return rect.applying(xfrm)
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
            
            let pinIcon = UIImage(named: "autobus")
            //let pinIcon = UIImage(systemName: "arrowtriangle.down.fill")
            annotView?.image = pinIcon
            annotView?.backgroundColor = .yellow
            //annotView?.frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
            annotView?.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
            
            let annotationLabel = UILabel(frame: CGRect(x: pinIcon!.size.width/13, y: pinIcon!.size.width/12, width: 26, height: 26)) // change to height
            annotationLabel.backgroundColor = .blue
            annotationLabel.numberOfLines = 0
            annotationLabel.textAlignment = .center
            annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
            annotationLabel.text = annotation.title!
            annotationLabel.textColor = .red
            annotationLabel.backgroundColor = UIColor(named: colorName)
            annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
            annotationLabel.layer.masksToBounds = true
            annotationLabel.layer.borderWidth = 2
            annotationLabel.layer.borderColor = UIColor.white.cgColor
            annotView?.addSubview(annotationLabel)
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
        
        @objc func normalTap(_ sender: UIGestureRecognizer, mapView: MKMapView, annotationView: AnnotationView) {
            
        }
        
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            } else {
//                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//                let imageForAnnotation = UIImage(named: "autobus")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//                let annotationTitle = annotation.title!
//                annotationView.image = combineImageAndTitle(image: imageForAnnotation, title: annotationTitle!)
//                return annotationView
//            }
//        }
//
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//            if annotation.isKind(of: MKUserLocation.self) {
//                return nil
//            } else {
//
//                let identifier: String = "CustomViewAnnotation"
//
//                var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
//
//                if let annotationView = annotView {
//                    return annotationView
//
//                } else {// nil
//
//                    annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//                    let pinIcon = UIImage(named: "autobus")
//                    annotView?.btnInfo = UIButton()
//                    annotView?.frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
//                    annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
//                    annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//                    annotView?.addSubview(annotView?.btnInfo ?? UIButton())
//
//                    let annotationLabel = UILabel(frame: CGRect(x: 19.5, y: 19.5, width: 26, height: 26))
//                    annotationLabel.numberOfLines = 0
//                    annotationLabel.textAlignment = .center
//                    annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                    annotationLabel.text = annotation.title!
//                    annotationLabel.textColor = .red
//                    annotationLabel.backgroundColor = .yellow
//                    annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
//                    annotationLabel.layer.masksToBounds = true
//                    annotationLabel.layer.borderWidth = 2
//                    annotationLabel.layer.borderColor = UIColor.white.cgColor
//                    annotView?.addSubview(annotationLabel)
//
//                    return annotView
//                }
//            }
//        }
        
        /// Combine image and title in one image.
        func combineImageAndTitle(image: UIImage, title: String) -> UIImage {
            // Create an image from ident text
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
            label.numberOfLines = 1
            label.textAlignment = .center
            label.textColor = UIColor.systemYellow
            label.text = title
            label.font = UIFont(name: "HelveticaNeue-Bold", size: 16.0)
            let titleImage = UIImage.imageFromLabel(label: label)
            
            // Resulting image has a 100 by 100 size
            let contextSize = CGSize(width: 48, height: 48)
            
            UIGraphicsBeginImageContextWithOptions(contextSize, false, UIScreen.main.scale)
            
            let rect1 = CGRect(x: 0, y: 0, width: Int(image.size.width)/5, height: Int(image.size.height)/5)
            image.draw(in: rect1)
            
            let rect2 = CGRect(x: 0, y: Int(titleImage.size.height)/2, width: Int(titleImage.size.width), height: Int(titleImage.size.height))
            titleImage.draw(in: rect2)
            
            let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return combinedImage!
        }
        
    }
}
