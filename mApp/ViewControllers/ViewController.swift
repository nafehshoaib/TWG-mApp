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
import Siesta
import SwiftyJSON

public var isLoggedIn = false
public var numberOfChairs = (6 * 5) + (8 * 3) + (10 * 3)


class ViewController: NSViewController {
    
    //@IBOutlet var pdfView: PDFView?
    //var doc: PDFDocument = PDFDocument(URL: NSBundle.mainBundle().URLForResource("Floorplan_2016.06.25.png", withExtension: "pdf"))
    
    // MapView Storyboard connection
    @IBOutlet var mapView: MKMapView?
    // Office model, to access Office's coordinates in world
    var office = Office(filename: "OfficeMapCoordinates")
    // Firebase helper object
    let firebase = Service(baseURL: "https://mapps-31c97.firebaseio.com/", useDefaultTransformers: true)
    
    let isUsingFirebase = false
    let isUsingJSON = true
    
    // Access JSON file of all employees
    let jsonFile = NSBundle.mainBundle().pathForResource("Data", ofType: "json")!
    let jsonLink = NSURL(string: "https://www.dropbox.com/s/0na2kd287r8lrn5/Data.json?dl=0")
    
    // Test with property list
    let filePath = NSBundle.mainBundle().pathForResource("DataP", ofType: "plist")
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        //pdfView?.setDocument(doc)
        // calculate the length of the area in data, to then use it as the span of the MapView
        let latDelta = (office.overlayTopLeftCoordinate.latitude -
            office.overlayBottomRightCoordinate.latitude) / 2.5
        
        // set the span of the map
        let span = MKCoordinateSpanMake(fabs(latDelta), 0.0)
        let region = MKCoordinateRegionMake(office.midCoordinate, span)
        
        mapView!.region = region
        
        // Add map overlays
        addOverlay()
        
        // add Annotations, aka pins
        var employees: [Employee] = []
        
        // load data from firebase
        let data = firebase.resource("")
        data.load()
        print("\(data.jsonDict)")
        
        // get data from jsonFile, as declared above
        let jsonData = NSData(contentsOfFile: jsonFile)
        let json = JSON(data: jsonData!)
        let properties: NSDictionary = NSDictionary(contentsOfFile: filePath!)!
        
        // for loop to systematically drop pins
        for i in 0...numberOfChairs-2 {
            var firstName: String? = ""
            var lastName: String? = ""
            var title: String? = ""
            var email: String? = ""
            var interests: String? = ""
            var skills: String? = ""
            var tableNumber: Int? = 0
            var seatNumber: Int? = 0
            
            if isUsingFirebase {
                let child = data.child(String(i)).jsonDict
                firstName = child["First Name"] as? String
                lastName = child["Last Name"] as? String
                title = child["Title"] as? String
                email = child["Emai"] as? String
                interests = child["Interests"] as? String
                skills = child["Skills"] as? String
                tableNumber = child["Table Number"] as? Int
                seatNumber = child["Seat Number"] as? Int
            } else if isUsingJSON {
                let childJSON = json[String(i+1)]
                firstName = childJSON["First Name"].stringValue
                lastName = childJSON["Last Name"].stringValue
                title = childJSON["Title"].stringValue
                email = childJSON["Email"].stringValue
                interests = childJSON["Interests"].stringValue
                skills = childJSON["Skills"].stringValue
                tableNumber = childJSON["Table Number"].intValue
                seatNumber = childJSON["Seat Number"].intValue
            }
//            else {
//                let childList = properties[String(i+1)] as! NSDictionary
//                firstName = childList["First Name"] as? String
//                lastName = childList["Last Name"] as? String
//                title = childList["Title"] as? String
//                email = childList["Emai"] as? String
//                interests = childList["Interests"] as? String
//                skills = childList["Skills"] as? String
//                tableNumber = childList["Table Number"] as? Int
//                seatNumber = childList["Seat Number"] as? Int
//            }
            
            let person = Employee(firstName: firstName, lastName: lastName, position: title, email: email, skills: skills, interests: interests, tableNumber: tableNumber, chairNumber: seatNumber)
            employees.append(person)
        }
        mapView?.addAnnotations(employees)
    }
    
    // search field test
    @IBAction func searchFieldOne(sender: NSSearchField) {
        sender.placeholderString = "Hello ITs EM"
    }
    
    // display login viewController if not logged in
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
    
    // add overlays as previously loaded
    func addOverlay() {
        let overlay = OfficeMapOverlay(office: office)
        mapView?.addOverlay(overlay)
    }

}

// MARK: - Map View delegate
// extension to separate code bases
extension ViewController: MKMapViewDelegate {
    
    // MapOverlay Setup
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let officeImage = NSImage(named: "FloorPlan_Edited_WhiteSpace")
        let overlayView = OfficeMapOverlayView(overlay: overlay, overlayImage: officeImage!)
        
        return overlayView
    }

    // setup mapView annotations using custom model
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if let annotation = annotation as? Employee {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView { // 2
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                // 3
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
            }
            return view
        }
        return nil
    }
    
    // handling of selecting a pin
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        var objects: NSArray?
        var customView = EmployeeView()
        let employeeAnnotation = view.annotation as! Employee
        customView.name?.stringValue = employeeAnnotation.title!
        customView.position?.stringValue = employeeAnnotation.subtitle_
        customView.skills?.stringValue = employeeAnnotation.skills!
        customView.interests?.stringValue = employeeAnnotation.interests!
        customView.email = employeeAnnotation.email!
        view.addSubview(customView)
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

