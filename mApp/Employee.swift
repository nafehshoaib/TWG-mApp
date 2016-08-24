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
    let interests: String
    let skills: String
    let coordinate: CLLocationCoordinate2D
    
    init(title_: String, interests: String, skills: String, coordinate: CLLocationCoordinate2D) {
        self.title = title_
        self.interests = interests
        self.skills = skills
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return interests
    }

}



/*
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        // Drawing code here.
    }
    
    init(tableNumber: Int, chairNumber: Int) {
        coordinate = CoordinateSystem(filename: "OfficeMapCoordinates", tableNumber: tableNumber, chairNumber: chairNumber).coordinatesFromSystem
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
*/