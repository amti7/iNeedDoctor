//
//  MapViewController.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 22.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import Foundation
import MapKit
import UIKit
import CoreLocation
import CoreData

class MapViewController: UIViewController{
    
    @IBOutlet weak var mapView: MKMapView!
    
    var medPlaceArray: [NSManagedObject] = []
    

    
    let ScanmedInWarsawPin = CLLocationCoordinate2D(latitude: 52.19479, longitude: 21.01371)
    
    let regionRadius: CLLocationDistance = 10000
    
    
    // let initialLocationForCracow = CLLocation(latitude:50.064650, longitude: 19.944979)
    // let initialLocationForWarsaw = CLLocation(latitude: 52.229675, longitude: 21.012228)
    
    
    
    var placeLatitude: Double = 0.0
    var placeLongitude: Double = 0.0
    var cityLatitude: Double = 0.0
    var cityLongitude: Double = 0.0
    var name: String = ""
    var street: String = ""
    
    
    override func viewDidLoad() {
        let initialLocation =  CLLocation(latitude: cityLatitude, longitude: cityLongitude)
        centerMapOnLoaction(location: initialLocation)
        
        mapView.delegate = self
        
        let medicalAnnotation = MedicalAnnotation(name: name, street: street, location: ScanmedInWarsawPin)
        //let medicalAnnotation = MedicalAnnotation(name: name, street: street, latitude: latitude, longitude: longitude)
        mapView.addAnnotation(medicalAnnotation)
    }

    func centerMapOnLoaction(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
}


extension MapViewController: MKMapViewDelegate{

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {

        guard let annotation = annotation as? MedicalAnnotation else { return nil }

        let identifier = "marker"
        var view: MKMarkerAnnotationView

        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

