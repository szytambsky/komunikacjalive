//
//  ClusterView.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 23/10/2021.
//

// MARK: - Info
//Abstract:
//A subclass of MKAnnotationView that configures itself for representing a MKClusterAnnotation with only Bike member annotations.

import Foundation
import MapKit

class ClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
//                let uniCount = cluster.memberAnnotations.filter { member -> Bool in
//                    return (member as! Bike).type == .unicycle
//                }.count
                image = renderer.image { _ in
                    // Fill full circle with tricycle color
                    UIColor(named: "tramCol")?.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    
                    // Fill pie with unicycle color
                    UIColor(named: "busCol")?.setFill()
                    let piePath = UIBezierPath()
//                    piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
//                                   startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(uniCount)) / CGFloat(count),
//                                   clockwise: true)
                    piePath.addLine(to: CGPoint(x: 20, y: 20))
                    piePath.close()
                    piePath.fill()
                    
                    // Fill inner circle with white color
                    UIColor.white.setFill()
                    UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
                    
                    // Finally draw count text vertically and horizontally centered
                    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
            }
        }
    }

}
