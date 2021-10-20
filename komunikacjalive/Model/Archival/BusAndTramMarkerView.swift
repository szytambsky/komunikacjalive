//
//  BusAndTramMarkerView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 18/10/2021.
//

import Foundation
import MapKit

class BusAndTramMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let vehicle = newValue as? VehicleAnnotation else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            // 2
            //image = UIImage(named: "autobus")
            markerTintColor = UIColor(vehicle.tint)
            //glyphText = vehicle.lineName
            canShowCallout = false
        }
    }
}
