//
//  InformationAboutAnnotations.swift
//  komunikacjalive
//
//  Created by Szymon Tamborski on 05/11/2021.
//

import Foundation

//// If we declare an MKAnnotationView in other class file and override MKAnnotation we have to register it here not in view for
//view.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: "bus")
//view.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: "cluster")

/////without register
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            } else {
//
//                let identifier: String = "CustomViewAnnotation"
//
//                var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
//                annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//                let pinIcon = UIImage(named: "autobus")
//                //let pinIcon = UIImage(systemName: "arrowtriangle.down.fill")
//                annotView?.btnInfo = UIButton()
//                annotView?.frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
//                annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
//                annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//                annotView?.addSubview(annotView?.btnInfo ?? UIButton())
//                let annotationLabel = UILabel(frame: CGRect(x: 19.5, y: 19.5, width: 26, height: 26))
//                annotationLabel.numberOfLines = 0
//                annotationLabel.textAlignment = .center
//                annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                annotationLabel.text = annotation.title!
//                annotationLabel.textColor = .red
//                annotationLabel.backgroundColor = .yellow
//                annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
//                annotationLabel.layer.masksToBounds = true
//                annotationLabel.layer.borderWidth = 2
//                annotationLabel.layer.borderColor = UIColor.white.cgColor
//                annotView?.addSubview(annotationLabel)
//                annotView?.clusteringIdentifier = "bus"
//
//                return annotView
//            }
//        }
        
////with register
//        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//            if annotation is MKUserLocation {
//                return nil
//            }
//            if let bus = annotation as? VehicleAnnotation {
//                var view = mapView.dequeueReusableAnnotationView(withIdentifier: "bus") as? AnnotationView
//                if view == nil {
//                    view = AnnotationView(annotation: bus, reuseIdentifier: "bus")
//                }
//                return view
//            } else if let cluster = annotation as? MKClusterAnnotation {
//                var view = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? ClusterView
//                if view == nil {
//                    view = ClusterView(annotation: cluster, reuseIdentifier: "cluster")
//                }
//                return view
//            }
//
//            return nil
//        }
//
//class ClusterView: MKAnnotationView {
//    
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        displayPriority = .defaultHigh
//        collisionMode = .circle
//        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    override var annotation: MKAnnotation? {
//        willSet {
//            if let cluster = newValue as? MKClusterAnnotation {
//                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
//                let count = cluster.memberAnnotations.count
//                image = renderer.image { _ in
//                    // Fill full circle with tricycle color
//                    UIColor(named: "tramCol")?.setFill()
//                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
//                    
//                    // Fill pie with unicycle color
//                    UIColor(named: "busCol")?.setFill()
//                    let piePath = UIBezierPath()
//                    piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
//                                   startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(4)) / CGFloat(count),
//                                   clockwise: true)
//                    piePath.addLine(to: CGPoint(x: 20, y: 20))
//                    piePath.close()
//                    piePath.fill()
//                    
//                    // Fill inner circle with white color
//                    UIColor.white.setFill()
//                    UIBezierPath(ovalIn: CGRect(x: 8, y: 8, width: 24, height: 24)).fill()
//                    
//                    // Finally draw count text vertically and horizontally centered
//                    let attributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
//                    let text = "\(count)"
//                    let size = text.size(withAttributes: attributes)
//                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
//                    text.draw(in: rect, withAttributes: attributes)
//                }
//            }
//        }
//    }
//
//}
//
//class AnnotationView: MKAnnotationView {
//    var btnInfo: UIButton?
//    var btnLabel: UILabel?
//
//    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
//        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
//        //displayPriority = .defaultHigh
//        //collisionMode = .circle
//        //centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override var annotation: MKAnnotation? {
//        willSet {
//            if let bus = newValue as? VehicleAnnotation {
//                if bus.vehicleType == .bus {
//                    let pinIcon = UIImage(named: "autobus")
//                    //let pinIcon = UIImage(systemName: "arrowtriangle.down.fill")
//                    btnInfo = UIButton()
//                    frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
//                    btnInfo?.frame = frame
//                    btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//                    addSubview(btnInfo ?? UIButton())
//                    let annotationLabel = UILabel(frame: CGRect(x: 19.5, y: 19.5, width: 26, height: 26))
//                    annotationLabel.numberOfLines = 0
//                    annotationLabel.textAlignment = .center
//                    annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                    annotationLabel.text = annotation?.title!
//                    annotationLabel.textColor = .red
//                    annotationLabel.backgroundColor = .yellow
//                    annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
//                    annotationLabel.layer.masksToBounds = true
//                    annotationLabel.layer.borderWidth = 2
//                    annotationLabel.layer.borderColor = UIColor.white.cgColor
//                    addSubview(annotationLabel)
//                    clusteringIdentifier = "cluster"
//                    //displayPriority = .defaultLow
//                } else {
//                    let pinIcon = UIImage(named: "autobus")
//                    //let pinIcon = UIImage(systemName: "arrowtriangle.down.fill")
//                    btnInfo = UIButton()
//                    frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
//                    btnInfo?.frame = frame
//                    btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//                    addSubview(btnInfo ?? UIButton())
//                    let annotationLabel = UILabel(frame: CGRect(x: 19.5, y: 19.5, width: 26, height: 26))
//                    annotationLabel.numberOfLines = 0
//                    annotationLabel.textAlignment = .center
//                    annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//                    annotationLabel.text = annotation?.title!
//                    annotationLabel.textColor = .orange
//                    annotationLabel.backgroundColor = .green
//                    annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
//                    annotationLabel.layer.masksToBounds = true
//                    annotationLabel.layer.borderWidth = 2
//                    annotationLabel.layer.borderColor = UIColor.white.cgColor
//                    addSubview(annotationLabel)
//                    clusteringIdentifier = "cluster"
//                    //markerTintColor = UIColor(named: "tricycleCol")
//                    //glyphImage = UIImage(named: "tricycle")
//                    //displayPriority = .defaultHigh
//                }
//            }
//        }
//    }
//}
//

///// exisitng clsutering without proper diffrentiate on bus and tram
//
//func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//    if annotation is MKUserLocation {
//        return nil
//    } else if let cluster = annotation as? MKClusterAnnotation {
//        var view = mapView.dequeueReusableAnnotationView(withIdentifier: "cluster") as? ClusterView
//        if view == nil {
//            view = ClusterView(annotation: cluster, reuseIdentifier: "cluster")
//        }
//        return view
//    } else {
//        let identifier: String = "CustomViewAnnotation"
//
//        var annotView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? AnnotationView
//        annotView = AnnotationView(annotation: annotation, reuseIdentifier: identifier)
//
//        let pinIcon = UIImage(named: "autobus")
//        //let pinIcon = UIImage(systemName: "arrowtriangle.down.fill")
//        annotView?.btnInfo = UIButton()
//        annotView?.frame = CGRect(x: 0, y: 0, width: pinIcon!.size.width/4, height: pinIcon!.size.height/4)
//        annotView?.btnInfo?.frame = annotView?.frame ?? CGRect.zero
//        annotView?.btnInfo?.setBackgroundImage(pinIcon, for: .normal)
//        annotView?.addSubview(annotView?.btnInfo ?? UIButton())
//        let annotationLabel = UILabel(frame: CGRect(x: 19.5, y: 19.5, width: 26, height: 26))
//        annotationLabel.numberOfLines = 0
//        annotationLabel.textAlignment = .center
//        annotationLabel.font = UIFont.systemFont(ofSize: 12, weight: .bold)
//        annotationLabel.text = annotation.title!
//        annotationLabel.textColor = .red
//        annotationLabel.backgroundColor = .yellow
//        annotationLabel.layer.cornerRadius = (annotationLabel.frame.width/2)
//        annotationLabel.layer.masksToBounds = true
//        annotationLabel.layer.borderWidth = 2
//        annotationLabel.layer.borderColor = UIColor.white.cgColor
//        annotView?.addSubview(annotationLabel)
//        annotView?.clusteringIdentifier = "bus" // HAVE TO BE
//
//        return annotView
//    }

