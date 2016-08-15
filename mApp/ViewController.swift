//
//  ViewController.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-08.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import Quartz
import MapKit

class ViewController: NSViewController {
    
    //@IBOutlet var pdfView: PDFView?
    //var doc: PDFDocument = PDFDocument(URL: NSBundle.mainBundle().URLForResource("Floorplan_2016.06.25.png", withExtension: "pdf"))
    @IBOutlet var mapView: MKMapView?
    var office = Office(filename: "MapLocal")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pdfView?.setDocument(doc)
        
        let latDelta = office.overlayTopLeftCoordinate.latitude -
            office.overlayBottomRightCoordinate.latitude
        
        // think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let region = MKCoordinateRegionMake(office.midCoordinate, span)
        
        mapView!.region = region
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    func addOverlay() {
        let overlay = OfficeMapOverlay(office: office)
        mapView?.addOverlay(overlay)
    }
    

}

// MARK: - Map View delegate

extension ViewController: MKMapViewDelegate {
    


    
}

