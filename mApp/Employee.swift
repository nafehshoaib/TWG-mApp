//
//  Employee.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-19.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class Employee: MKAnnotationView /*MKAnnotation*/ {
    
    
    
    var title: String? = "John Appleseed"
    var subtitle: String?
    
    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)
        
        // Drawing code here.
    }
    
}
