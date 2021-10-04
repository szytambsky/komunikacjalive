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
    
    // Thanks to Combine these ones are favouriteLines
    //@Binding var vehicles: [VehicleAnnotation]
    var busesAndTrams: [BusAndTram]
    var vehiclesDictionary: [String: VehicleAnnotation]
    
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
        if let oldCoordinates = oldCoordinates[model.vehicleNumber], let oldCoordinates2 = oldCoordinates2[model.vehicleNumber] {
            let oldLocation = CLLocationCoordinate2D(latitude: oldCoordinates, longitude: oldCoordinates2)
            let newLocation = CLLocationCoordinate2D(latitude: model.latitude , longitude: model.longitude)
            let getAngle = self.angleFromCoordinate(firstCoordinate: oldLocation, secondCoordinate: newLocation)

            myAnnotation.coordinate = newLocation
            let annotationView = mapView.view(for: myAnnotation)
            annotationView?.transform = CGAffineTransform(rotationAngle: CGFloat(getAngle))
            //busesAndTrams = []
            //vehiclesDictionary = [:]
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
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil
            } else {
                let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
                let imageForAnnotation = UIImage(named: "autobus")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
                let annotationTitle = annotation.title!
                annotationView.image = combineImageAndTitle(image: imageForAnnotation, title: annotationTitle!)
                return annotationView
            }
            
        }
        
        /// Combine image and title in one image.
        func combineImageAndTitle(image: UIImage, title: String) -> UIImage {
            // Create an image from ident text
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
            label.numberOfLines = 1
            label.textAlignment = .center
            label.textColor = UIColor.white
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

//let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
//annotationView.image = UIImage(named: "autobus")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
//let size = CGSize(width: 42, height: 42)
//annotationView.image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
//    annotationView.image?.draw(in: CGRect(origin: .zero, size: size))
//})
//return annotationView

//let pinnedImage = UIImage(named: "autobus")
//annotationView?.vehicleButton = UIButton()
//annotationView?.frame = CGRect(x: 0, y: 0, width: (pinnedImage?.size.width)!, height: (pinnedImage?.size.height)!)
//annotationView?.vehicleButton?.frame = annotationView?.frame ?? CGRect.zero
//annotationView?.vehicleButton?.setBackgroundImage(pinnedImage, for: .normal)
//annotationView?.addSubview(annotationView?.vehicleButton ?? UIButton())
