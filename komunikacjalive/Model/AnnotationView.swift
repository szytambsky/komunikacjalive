//
//  AnnotationView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 19/10/2021.
//

// MARK: - Info
//Abstract:
//A subclass of MKAnnotationView that configures itself for representing a bus/tram.
//

import Foundation
import UIKit
import MapKit

class AnnotationView: MKAnnotationView {
    var btnInfo: UIButton?
    var btnLabel: UILabel?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
        //clusteringIdentifier = "cluster"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
