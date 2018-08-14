//
//  ViewController.swift
//  MapKitBug
//
//  Created by Edward Poot on 14-08-18.
//  Copyright © 2018 Felyx Sharing B.V. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        addAnnotation(latitude: 52.363338, longitude:  4.901001)
        addAnnotation(latitude: 52.363342, longitude: 4.901017)
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    func addAnnotation(latitude: Double, longitude: Double) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        mapView.addAnnotation(annotation)
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let cluster = annotation as? MKClusterAnnotation {
            let markerAnnotationView = MKMarkerAnnotationView()

            let numberOfAnnotations = cluster.memberAnnotations.count
            markerAnnotationView.glyphText = String(numberOfAnnotations)

            return markerAnnotationView
        }

        let annotationView = MKPinAnnotationView.init(annotation: annotation, reuseIdentifier: "Test")
        annotationView.clusteringIdentifier = "cluster"

        return annotationView
    }

    func mapView(_ mapView: MKMapView, clusterAnnotationForMemberAnnotations memberAnnotations: [MKAnnotation]) -> MKClusterAnnotation {
        return MKClusterAnnotation(memberAnnotations: memberAnnotations)
    }
}

