//
//  AnnotationView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 19/10/2021.
//

import Foundation
import UIKit
import MapKit

class AnnotationView: MKAnnotationView {
    var btnInfo: UIButton?
    var btnLabel: UILabel?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
