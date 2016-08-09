//
//  ViewController.swift
//  mApp
//
//  Created by Nafeh Shoaib on 2016-08-08.
//  Copyright © 2016 nafehshoaib. All rights reserved.
//

import Cocoa
import Quartz

class ViewController: NSViewController {
    
    @IBOutlet var pdfView: PDFView?
    var doc: PDFDocument = PDFDocument(URL: NSBundle.mainBundle().URLForResource("Floorplan_2016.06.25", withExtension: "pdf"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView?.setDocument(doc)
        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

