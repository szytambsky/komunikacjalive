//
//  AnnotationView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 22/09/2021.
//

import Foundation
import MapKit

class AnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        didSet { configure(for: annotation) }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        configure(for: annotation)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(for annotation: MKAnnotation?) {
        displayPriority = .required
        // if doing clustering, also add
        // clusteringIdentifier = ...
        image = UIImage(named: "autobus")?.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
        let size = CGSize(width: 42, height: 42)
        image = UIGraphicsImageRenderer(size: size).image(actions: { _ in
            image?.draw(in: CGRect(origin: .zero, size: size))
        })
    }
    
}

class CalloutAnnotationView: MKAnnotationView {
    var label: UILabel
    let calloutRect = CGRect(origin: CGPoint.zero, size: CGSize(width: 100, height: 100))
    
    init() {
        label = UILabel(frame: calloutRect.insetBy(dx: 8.0, dy: 8.0))
        label.textAlignment = .center
        label.numberOfLines = 0

        super.init(frame: calloutRect)

        self.addSubview(label)
        self.backgroundColor = UIColor.white
        self.centerOffset = CGPoint(x: 0.0, y: -(calloutRect.size.height / 2))
        self.layer.cornerRadius = 6.0
    }

    required init?(coder aDecoder: NSCoder) {
        label = UILabel(frame: calloutRect.insetBy(dx: 8.0, dy: 8.0))
        super.init(coder: aDecoder)
    }
}
