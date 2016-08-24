//
//  EmployeeTemp.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-24.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class EmployeeTemp: NSObject, MKAnnotation {
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    required init(firstName: String, lastName: String, position: String, skills: String, interests: String, tableNumber: Int, chairNumber: Int) {
        self.title = firstName + " " + lastName
        self.subtitle = position
        self.coordinate = CoordinateSystem(filename: "OfficeMapCoordinates", tableNumber: tableNumber, chairNumber: chairNumber).coordinatesFromSystem
    }
}
