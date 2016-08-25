//
//  Employee.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-19.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class Employee: NSObject, MKAnnotation {
    
    let title: String?
    let subtitle: String?
    let interests: String?
    let skills: String?
    let email: String?
    let coordinate: CLLocationCoordinate2D
    
    required init(firstName: String?, lastName: String?, position: String?, email: String?, skills: String?, interests: String?, tableNumber: Int?, chairNumber: Int?) {
        if (firstName != nil) && (lastName != nil) {
            self.title = firstName! + " " + lastName!
        } else if firstName != nil {
            self.title = firstName
        } else {
            self.title = "Hello"
        }
        if position != nil {
            self.subtitle = position
        } else {
            self.subtitle = "No position added"
        }
        self.skills = skills
        self.interests = interests
        self.email = email
        let coordinateSus = CoordinateSystem(filename: "OfficeMapCoordinates", tableNumber: tableNumber!, chairNumber: chairNumber!)
        self.coordinate = coordinateSus.coordinatesFromSystem
    }
    
    var subtitle_: String {
        return subtitle!
    }
    
}