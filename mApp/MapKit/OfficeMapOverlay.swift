//
//  OfficeMapOverlay.swift
//  mApp
//
//  Created by Mehta on 2016-08-15.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class OfficeMapOverlay: NSObject, MKOverlay {
    var coordinate: CLLocationCoordinate2D
    var boundingMapRect: MKMapRect
    
    init(office: Office) {
        boundingMapRect = office.overlayBoundingMapRect
        coordinate = office.midCoordinate
    }
}
