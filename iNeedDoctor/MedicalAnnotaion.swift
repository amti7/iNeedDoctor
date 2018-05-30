//
//  AnnotaionObject\.swift
//  iNeedDoctor
//
//  Created by Kamil Gacek on 29.05.2018.
//  Copyright © 2018 Kamil Gacek. All rights reserved.
//

import Foundation
import MapKit

class MedicalAnnotation: NSObject, MKAnnotation {
    
    let title: String?
    let street: String
    let coordinate: CLLocationCoordinate2D
    
    init(name: String, street: String,location: CLLocationCoordinate2D){ //latitude: Double, longitude: Double) {
        self.title = name
        self.street = street
        self.coordinate = location
       // self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var subtitle: String? {
        return street
    }
    
}
