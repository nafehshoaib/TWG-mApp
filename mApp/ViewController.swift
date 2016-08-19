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

public var isLoggedIn = false
public var numberOfChairs = (6 * 5) + (8 * 3) + (10 * 3)

class ViewController: NSViewController {
    
    
    //@IBOutlet var pdfView: PDFView?
    //var doc: PDFDocument = PDFDocument(URL: NSBundle.mainBundle().URLForResource("Floorplan_2016.06.25.png", withExtension: "pdf"))
    @IBOutlet var mapView: MKMapView?
    var office = Office(filename: "OfficeMapCoordinates")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //pdfView?.setDocument(doc)
        
        let latDelta = (office.overlayTopLeftCoordinate.latitude -
            office.overlayBottomRightCoordinate.latitude) / 2.5
        
        // think of a span as a tv size, measure from one corner to another
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        
        let region = MKCoordinateRegionMake(office.midCoordinate, span)
        
        mapView!.region = region
        // Do any additional setup after loading the view.
        addOverlay()
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        if !isLoggedIn {
            displayLogin()
        } else {
            
        }
    }
    
    func displayLogin() {
        let nextViewController = storyboard?.instantiateControllerWithIdentifier("loginVC") as! LoginViewController
        presentViewControllerAsSheet(nextViewController)
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
    
    // MapOverlay Setup
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let officeImage = NSImage(named: "FloorPlan_Edited_WhiteSpace")
        let overlayView = OfficeMapOverlayView(overlay: overlay, overlayImage: officeImage!)
        
        return overlayView
    }
    
    /*
    func mapView(mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        mapView.region.span.latitudeDelta = mapView.region.span.latitudeDelta / fabs(0.1)
    } */
    
    /*
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if ((mapView.region.span.latitudeDelta > 5.34343) || (mapView.region.span.longitudeDelta > 22324.23322)) {
            //let centerCoord:CLLocationCoordinate2D = CLLocationCoordinate2DMake(-41.162114, 172.836914);
            let spanOfNZ:MKCoordinateSpan = MKCoordinateSpanMake(13.589921, 14.062500);
            let NZRegion:MKCoordinateRegion = MKCoordinateRegionMake(centerCoord, spanOfNZ);
            mapView .setRegion(NZRegion, animated: true);
        }
    }
     */
}

