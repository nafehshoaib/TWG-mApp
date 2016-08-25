//
//  CoordinateSystem.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-19.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import MapKit

class CoordinateSystem {
    
    var coordinatesFromSystem: CLLocationCoordinate2D
    
    init (filename: String, tableNumber: Int, chairNumber: Int) {
        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        let properties: NSDictionary = NSDictionary(contentsOfFile: filePath!)!
        
        let poi = properties["POIs"] as! NSDictionary
        let table = poi["Table " + String(tableNumber)] as! NSDictionary
        let chair: NSDictionary = table["Chair " + String(chairNumber)] as! NSDictionary
        
        let coordsLat = chair["Lat"] as! Double
        let coordsLong = chair["Long"] as! Double
        
        //let psuedoCoordinates: String = "{" + (String(chair["Lat"] as! Float)) + "," + (String(chair["Long"] as! Float)) + "}"
        
        //let psuedoPoint: NSPoint = NSPointFromString(psuedoCoordinates)
        
        coordinatesFromSystem = CLLocationCoordinate2DMake(CLLocationDegrees(coordsLat), CLLocationDegrees(coordsLong))
    }
}
