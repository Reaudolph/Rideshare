//
//  DriverA.swift
//  UwUber
//
//  Created by Hrishikesh Vikram on 4/19/22.
//

//

import MapKit

class DriverA: NSObject, MKAnnotation {
    dynamic var coordinate: CLLocationCoordinate2D
    var uid: String
    
    init(uid: String, coordinate: CLLocationCoordinate2D) {
        self.uid = uid
        self.coordinate = coordinate
    }
    
}
