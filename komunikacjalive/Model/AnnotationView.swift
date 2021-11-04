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
}
