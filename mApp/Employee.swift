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
        /*
    let interests: String?

    let skills: String?
    let email: String?
    */
    let coordinate: CLLocationCoordinate2D
    
    required init(title: String, subtitle: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle_: String {
        return subtitle!
    }
    

    /*
    
    required init(firstName: String?, lastName: String?, position: String?, email: String?, skills: String?, interests: String?, tableNumber: Int?, chairNumber: Int?) {
        self.title = firstName! + " " + lastName!
        self.subtitle = position
        self.skills = skills
        self.interests = interests
        self.email = email
        self.coordinate = CoordinateSystem(filename: "OfficeMapCoordinates", tableNumber: tableNumber!, chairNumber: chairNumber!).coordinatesFromSystem
    }
*/
}